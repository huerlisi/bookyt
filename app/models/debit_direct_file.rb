class DebitDirectFile < ActiveRecord::Base
  attr_accessible :content

  has_many :debit_invoices

  validates :content, :presence => true
end
