# Invoice factories
require File.expand_path('../customers', __FILE__)
require File.expand_path('../companies', __FILE__)

Factory.define :invoice do |f|
  f.customer Factory.build(:customer)
  f.company Factory.build(:company)
  f.value_date '2010-09-20'
  f.due_date '2010-10-20'
  f.state "new"
  f.title "New Invoice"
  f.amount 99.85
end

Factory.define :credit_invoice, :parent => :invoice, :class => CreditInvoice do |f|
  
end
