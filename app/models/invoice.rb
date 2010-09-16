class Invoice < ActiveRecord::Base
  # Aspects
  include ApplicationHelper
  
  # Associations
  belongs_to :customer
  belongs_to :company, :class_name => 'Employer'
  
  # Helpers
  def to_s
    "%s für %s à %s" % [title, customer, currency_fmt(amount)]
  end
end
