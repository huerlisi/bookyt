class Tenant < ActiveRecord::Base
  # Admin Tenant
  # ============
  belongs_to :admin_tenant, :class_name => 'Admin::Tenant'
  attr_accessible :admin_tenant

  # Settings
  # ========

  has_settings do |s|
    s.key :payment, :defaults => { :period => 30.days }
    s.key :modules, :defaults => { :active => [] }
  end

  # User
  # ====
  has_many :users
  attr_accessible :user_ids

  # Company
  # =======
  attr_accessible :company, :company_attributes
  belongs_to :company, :foreign_key => :person_id, :autosave => true
  validates_presence_of :company
  accepts_nested_attributes_for :company

  def company
    super || build_company
  end

  def to_s
    company.to_s
  end

  # Bookyt
  # ======
  # Fiscal Years
  attr_accessible :fiscal_year_ends_on
  attr_accessible :incorporated_on

  def fiscal_period(year)
    month = fiscal_year_ends_on.try(:month) || 12
    day = fiscal_year_ends_on.try(:day) || 31
    final_day_of_fiscal_year = Date.new(year, month, day)
    first_day_of_fiscal_year = final_day_of_fiscal_year.ago(1.year).in(1.day)

    return :from => first_day_of_fiscal_year.to_date, :to => final_day_of_fiscal_year.to_date
  end

  # Describe passed fiscal years
  #
  # Returns empty array if fiscal_year_ends_on is not set.
  def fiscal_years
    # Guard
    if fiscal_year_ends_on.blank?
      if Booking.count == 0
        first_year = Date.today.year
      else
        first_year = Booking.order(:value_date).first.value_date.year
      end
    else
      first_year = fiscal_year_ends_on.year
    end
      final_year = Date.today.year + 1

    (first_year..final_year).map{|year|
      fiscal_period(year)
    }
  end

  # Describe passed calendar years
  #
  # Returns empty array if incorporated_on is not set.
  def calendar_years
    # Guard
    return [] unless incorporated_on

    first_year = incorporated_on.year
    final_year = Date.today.year

    (first_year..final_year).map{ |year|
      {
        :from => Date.new(year, 1, 1),
        :to => Date.new(year, 12, 31)
      }
    }

  end

  # Vat
  attr_accessible :vat_number, :uid_number, :ahv_number
  def vat_obligation?
    vat_number.present?
  end

  # Invoicing
  attr_accessible :print_payment_for, :use_vesr

  attr_accessible :payment_period
  def payment_period
    settings(:payment).period / 24 / 3600
  end

  def payment_period=(value)
    settings(:payment).period = value.to_i.days
  end

  # Attachments
  # ===========
  has_many :attachments, :as => :reference
  accepts_nested_attributes_for :attachments, :reject_if => proc { |attributes| attributes['file'].blank? }

  # Import/Export
  # =============
  has_many :backups, :as => :reference


  # Debit Direct
  # ============
  attr_accessible :debit_direct_identification
  validates_format_of :debit_direct_identification, with: /\A[A-Z0-9]{5}\z/, allow_blank: true
end
