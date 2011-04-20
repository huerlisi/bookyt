class Employment < ActiveRecord::Base
  # Associations
  belongs_to :employee
  belongs_to :employer, :class_name => 'Company'
  
  # Validations
  validates_presence_of :employee, :employer
  validates_date :duration_from, :duration_to, :allow_nil => true, :allow_blank => true

  # String
  def to_s
    "%s bei %s von %s - %s" % [employee, employer, duration_from, duration_to]
  end

  # Attachments
  # ===========
  has_many :attachments, :as => :object
  accepts_nested_attributes_for :attachments
end
