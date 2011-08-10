class LineItem < ActiveRecord::Base
  belongs_to :item, :polymorphic => true
  belongs_to :invoice, :touch => true

  # Validations
  validate :times, :presence => true, :numericality => true
  validate :price, :presence => true, :numericality => true
  validate :title, :presence => true
  
  # Attributes
  def assign_item=(value)
    self.item = value

    self.price = value.price
    self.title = value.title
    self.code  = value.code
  end

  def total_amount
    times * price.to_f
  end
end
