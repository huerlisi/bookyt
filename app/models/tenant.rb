class Tenant < ActiveRecord::Base
  # Associations
  belongs_to :company, :foreign_key => :person_id
  accepts_nested_attributes_for :company
  has_many :users

  # Validations
  validates_presence_of :company

  # String
  def to_s
    company.to_s
  end

  # Attachments
  # ===========
  has_many :attachments, :as => :object
  accepts_nested_attributes_for :attachments, :reject_if => proc { |attributes| attributes['file'].blank? }
end
