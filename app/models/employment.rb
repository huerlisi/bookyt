class Employment < ActiveRecord::Base
  # Associations
  belongs_to :employee, :inverse_of => :employments
  belongs_to :employer, :class_name => 'Company'
  scope :by_employee, lambda {|value| where(:employee_id => value)}

  # Validations
  validates_presence_of :employee, :employer
  validates_date :duration_from, :duration_to, :allow_nil => true, :allow_blank => true

  # Validity
  scope :valid_at, lambda {|value| where("duration_from <= :date AND (duration_to IS NULL OR duration_to > :date)", :date => value) }
  scope :valid, lambda { valid_at(Date.today) }
  scope :valid_during, lambda {|period| where("(duration_from IS NULL OR duration_from <= :to) AND (duration_to IS NULL OR duration_to >= :from)", :from => period.first, :to => period.last)}

  def self.current(date = nil)
    date ||= Date.today
    valid_at(date).last
  end

  # String
  def to_s
    "%s bei %s von %s - %s" % [employee, employer, duration_from, duration_to]
  end

  # Attachments
  # ===========
  has_many :attachments, :as => :reference
  accepts_nested_attributes_for :attachments, :reject_if => proc { |attributes| attributes['file'].blank? }
end
