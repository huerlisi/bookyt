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

  # Attributes
  def effective_price
    return price unless price.nil?

    if reference_code
      # TODO: matches all to many items when reference_code is null
      price_line_item = invoice.line_items.select{|item| item.code == reference_code}.first
      return price_line_item.try(:total_amount) || 0
    else
      return 0
    end
  end

  def total_amount
    if quantity == "saldo_of"
      included = invoice.line_items.select{|item|
        item.include_in_saldo_list.include?(reference_code)
      }
      return included.sum(&:total_amount)
    end

    return 0 if times.blank?
    if quantity == "%"
      return times / 100 * effective_price
    else
      return times * effective_price
    end
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

  # Vat Rate
  def vat_rate
    invoice.present? ? ChargeRate.current(vat_rate_code, invoice.value_date) : 0
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
    elsif value.amount_relates_to.present?
      self.quantity = 'saldo_of'
    else
      self.quantity = 'x'
      self.times    = 1
      self.price    = value.amount
    end
  end
end
