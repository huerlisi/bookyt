# Invoice factories

Factory.define :invoice do |f|
  f.association :customer
  f.association :company
  f.value_date '2010-09-20'
  f.due_date '2010-10-20'
  f.state "new"
  f.title "New Invoice"
  f.amount 99.85
end

Factory.define :credit_invoice, :parent => :invoice, :class => CreditInvoice do |f|

end
