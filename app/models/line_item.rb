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

  # Attributes
  def total_amount
    return 0 if times.blank? or price.blank?
    if quantity == "%"
      effective_times = times / 100
    else
      effective_times = times
    end

    effective_times * price.to_f
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

    if value.amount.match(/%/)
      self.quantity = '%'
      self.times    = value.amount.delete('%')
      # TODO: hack
      self.price    = invoice.line_items.select{|item| item.include_in_saldo_list.include?(value.amount_relates_to)}.sum(&:total_amount)
    else
      self.quantity = 'x'
      self.times    = 1
      self.price    = value.amount
    end
  end
end
