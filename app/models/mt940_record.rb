class Mt940Record < ActiveRecord::Base
  belongs_to :mt940_record, :inverse_of => :mt940_records
end
