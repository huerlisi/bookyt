class Tenant < ActiveRecord::Base
  belongs_to :company, :foreign_key => :person_id
end
