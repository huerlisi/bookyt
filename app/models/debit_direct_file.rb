class DebitDirectFile < ActiveRecord::Base
  attr_accessible :content, :debit_invoice_ids

  has_many :debit_invoices

  validates :content, :presence => true

  def to_s
    "#{id}: #{I18n.l(created_at.to_date)}"
  end
end
