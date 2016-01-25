class DebitDirectFile < ActiveRecord::Base
  attr_accessible :content, :debit_invoice_ids

  has_many :debit_invoices

  validates :content, :presence => true
end
