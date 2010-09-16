class Invoice < ActiveRecord::Base
  # Associations
  belongs_to :customer
  belongs_to :company
end
