class LineItem < ActiveRecord::Base
  belongs_to :item, :polymorphic => true
  belongs_to :invoice

  # Validations
  validate :quantity, :presence => true, :numericality => true
  validate :price, :presence => true, :numericality => true
  validate :title, :presence => true
  
  # Attributes
  def assign_item=(value)
    self.item = value

    self.amount = value.amount
    self.title  = value.title
    self.code   = value.code
  end

  def total_amount
    quantity * amount.to_f
  end
end
