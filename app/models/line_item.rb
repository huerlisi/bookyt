class LineItem < ActiveRecord::Base
  # Aspects
  include ApplicationHelper

  # Ordering
  default_scope order(:position)

  # Associations
  belongs_to :invoice, :touch => true, :inverse_of => :line_items
  belongs_to :debit_account, :class_name => 'Account'
  belongs_to :credit_account, :class_name => 'Account'

  # Validations
  validates :invoice, :presence => true
  validates :times, :presence => true, :numericality => true, :unless => :is_a_saldo_line_item?
  validates :price, :presence => true, :numericality => true
  validates :title, :presence => true
  validates :credit_account, :presence => true, :unless => :is_a_saldo_line_item?
  validates :debit_account, :presence => true, :unless => :is_a_saldo_line_item?

  # String
  def to_s
    "%s: %s (%s %s %s)" % [self.title, self.accounted_amount, self.times, self.quantity, self.price]
  end

  # Copying
  def copy
    new_item = dup
    new_item.include_in_saldo_list = include_in_saldo_list
    new_item
  end

  # Scopes
  scope :saldo_items, where(:quantity => 'saldo_of')
  scope :non_saldo_items, where("quantity != 'saldo_of'")

  def price=(value)
    if value.is_a? String
      self['price'] = BigDecimal.new(value)
    else
      self['price'] = value
    end
  end

  # Price getter
  #
  # Sum accounted amount over reverenced line items. Referencing can be using code or
  # saldo inclusion flags.
  #
  # Result is currency rounded. 0.0 is returned if no invoice is assigned.
  def price
    # If a price is set, use it
    return self[:price] unless self[:price].blank?

    # If a reference_code is given...
    if reference_code.present?
      # Guard against missing invoice
      return 0 unless invoice

      # ...and it references a line item...
      if price_line_item = invoice.line_items.select{|item| item.code == reference_code}.first
        # Return the total_amount
        return price_line_item.accounted_amount
      else
        # Sum over items to be included by tag
        included = invoice.line_items.select{|item| item.include_in_saldo_list.include?(reference_code) }
        return included.sum(&:accounted_amount)
      end
    else
      return 0
    end
  end

  def total_amount
    return 0 if times.blank?

    if quantity == "%"
      return (times / 100 * price).currency_round
    else
      return (times * price).currency_round
    end
  end

  def accounted_amount
    factor = 0
    factor = 1 if debit_account == invoice.direct_account
    factor = -1 if credit_account == invoice.direct_account

    return factor * total_amount * invoice.direct_account_factor
  end

  def times_to_s
    if times == 1
      if quantity == "x"
        s = ""
      elsif quantity == "overall"
        s = I18n::translate('overall', :scope => 'line_items.quantity')
      else
        s = "#{times} #{I18n::translate(quantity, :scope => 'line_items.quantity')}"
      end
    else
      s = "#{currency_fmt(times)} #{I18n::translate(quantity, :scope => 'line_items.quantity')}"
    end
  end

  # Item templates
  belongs_to :item, :polymorphic => true

  # Tagging
  acts_as_taggable_on :include_in_saldo

  # Bookings
  has_one :booking, :as => :template, :dependent => :destroy, :autosave => true

  before_save :update_booking
  def update_booking
    return unless self.credit_account && self.debit_account

    new_booking = booking || build_booking
    new_booking.attributes = {
      :title          => self.title,
      :amount         => self.total_amount,
      :value_date     => self.invoice.value_date,
      :credit_account => self.credit_account,
      :debit_account  => self.debit_account,
      :reference      => self.invoice
    }

    new_booking
  end

  # Booking templates
  belongs_to :booking_template

  before_validation :set_type

  private

  def set_type
    if self.quantity == 'saldo_of'
      self.type = "SaldoLineItem"
    else
      self.type = "LineItem"
    end
  end

  def is_a_saldo_line_item?
    self.type == "SaldoLineItem"
  end

end
