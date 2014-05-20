class Tenant < ActiveRecord::Base
  # Person
  # ======
  belongs_to :person
  accepts_nested_attributes_for :person
  attr_accessible :person_attributes
  def person_with_autobuild
    person_without_autobuild || build_person
  end
  alias_method_chain :person, :autobuild

  # Settings
  # ========
  has_settings
  attr_accessible :settings

  def to_s
    person.to_s
  end

  # User
  # ====
  has_many :users
  attr_accessible :user_ids

  # Company
  attr_accessible :company, :company_attributes
  belongs_to :company, :foreign_key => :person_id
  validates_presence_of :company
  accepts_nested_attributes_for :company

  # Bookyt
  # ======

  # Fiscal Years
  attr_accessible :fiscal_year_ends_on
  attr_accessible :incorporated_on
  validates_date :fiscal_year_ends_on
  validates_date :incorporated_on

  def fiscal_period(year)
    final_day_of_fiscal_year = Date.new(year, fiscal_year_ends_on.month, fiscal_year_ends_on.day)
    first_day_of_fiscal_year = final_day_of_fiscal_year.ago(1.year).in(1.day)

    return :from => first_day_of_fiscal_year.to_date, :to => final_day_of_fiscal_year.to_date
  end

  def fiscal_years
    first_year = fiscal_year_ends_on.year
    final_year = Date.today.year + 1

    (first_year..final_year).map{|year|
      fiscal_period(year)
    }
  end

  # Vat
  attr_accessible :vat_number, :uid_number, :ahv_number
  def vat_obligation?
    vat_number.present?
  end

  # Invoicing
  attr_accessible :payment_period, :print_payment_for, :use_vesr

  def payment_period
    settings.payment_period / 24 / 3600
  end
  def payment_period=(value)
    settings.payment_period = value.to_i.days
  end

  # Attachments
  # ===========
  has_many :attachments, :as => :object
  accepts_nested_attributes_for :attachments, :reject_if => proc { |attributes| attributes['file'].blank? }

  # Import/Export
  # =============
  has_many :backups, :as => :object

  # Export Data as YAML
  #
  # This method creates a YAML file out of all the records in the database.
  # This file is then attached to the Tenant record.
  #
  # Use this method for backup or migrations.
  #
  # @returns backup
  def export
    backup = backups.build
    backup.export
    backup.save!

    backup
  end
end
