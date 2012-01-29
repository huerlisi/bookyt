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
  validate :times, :presence => true, :numericality => true
  validate :price, :presence => true, :numericality => true
  validate :title, :presence => true

  # String
  def to_s
    if quantity == "saldo_of"
      "%s: %s (%s %s)" % [self.title, self.total_amount, self.quantity, self.reference_code]
    else
      "%s: %s (%s %s %s)" % [self.title, self.total_amount, self.times, self.quantity, self.effective_price]
    end
  end

  # Scopes
  scope :saldo_items, where(:quantity => 'saldo_of')
  scope :non_saldo_items, where("quantity != 'saldo_of'")

  # Attributes
  def price
    # If a price is set, use it
    return self[:price] unless self[:price].blank?

    # If a reference_code is given...
    if reference_code
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
    if quantity == "saldo_of"
      included = invoice.line_items.select{|item|
        item.include_in_saldo_list.include?(reference_code)
      }
      return included.sum(&:accounted_amount).currency_round
    end

    return 0 if times.blank?
    if quantity == "%"
      return (times / 100 * price).currency_round
    else
      return (times * price).currency_round
    end
  end

  def accounted_amount
    return total_amount if quantity == "saldo_of"

    factor = 0
    factor = -1 if credit_account == invoice.direct_account
    factor = 1 if debit_account == invoice.direct_account

    return factor * total_amount
  end

  def times_to_s
    return "" if quantity == "saldo_of"

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

  # Booking templates
  belongs_to :booking_template

  def set_booking_template(value)
    self.booking_template = value

    self.title          ||= value.title
    self.code           ||= value.code
    self.credit_account ||= value.credit_account
    self.debit_account  ||= value.debit_account
    self.position       ||= value.position
    self.include_in_saldo_list = value.include_in_saldo_list
    self.reference_code ||= value.amount_relates_to

    if value.amount.match(/%/)
      self.quantity = '%'
      self.times    = value.amount.delete('%')
      # TODO: hack
      self.price    = self.price
    elsif value.amount_relates_to.present?
      self.quantity = 'saldo_of'
      # TODO: hack
      self.price    = self.price
    else
      self.quantity = 'x'
      self.times    = 1
      self.price    = value.amount
    end
  end
end
