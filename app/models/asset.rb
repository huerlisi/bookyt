class Asset < ActiveRecord::Base
  # Invoice
  belongs_to :invoice
end
