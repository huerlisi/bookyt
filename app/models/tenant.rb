class Tenant < ActiveRecord::Base
  # Associations
  belongs_to :company, :foreign_key => :person_id
  accepts_nested_attributes_for :company
  has_many :users

  # Validations
  validates_presence_of :company
  validates_date :incorporated_on

  # String
  def to_s
    company.to_s
  end

  # Fiscal Years
  # ============
  validates_date :fiscal_year_ends_on

  def fiscal_period(year)
    final_day_of_fiscal_year = Date.new(year, fiscal_year_ends_on.month, fiscal_year_ends_on.day)
    first_day_of_fiscal_year = final_day_of_fiscal_year.ago(1.year).in(1.day)

    return :from => first_day_of_fiscal_year.to_date, :to => final_day_of_fiscal_year.to_date
  end
  
  def fiscal_years
    first_year = fiscal_year_ends_on.year
    final_year = Date.today.year + 1
    
    years = {}
    (first_year..final_year).map{|year|
      years[year] = fiscal_period(year)
    }
    
    return years
  end
  
  # Attachments
  # ===========
  has_many :attachments, :as => :object
  accepts_nested_attributes_for :attachments, :reject_if => proc { |attributes| attributes['file'].blank? }
end
