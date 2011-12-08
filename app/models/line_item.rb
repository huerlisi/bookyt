class LineItem < ActiveRecord::Base
  # Aspects
  include ApplicationHelper

  # Associations
  belongs_to :invoice, :touch => true
  belongs_to :contra_account, :class_name => 'Account'

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
end
