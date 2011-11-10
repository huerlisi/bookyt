class LineItem < ActiveRecord::Base
  # Aspects
  include ApplicationHelper

  # Associations
  belongs_to :invoice, :touch => true

  # Validations
  validate :times, :presence => true, :numericality => true
  validate :price, :presence => true, :numericality => true
  validate :title, :presence => true
  
  # Attributes
  def total_amount
    return 0 if times.blank? or price.blank?
    times * price.to_f
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
    ChargeRate.current(vat_rate_code, invoice.value_date)
  end

  # Item templates
  belongs_to :item, :polymorphic => true

  def assign_item=(value)
    self.item = value

    self.price = value.price
    self.title = value.title
    self.code  = value.code
  end
end
