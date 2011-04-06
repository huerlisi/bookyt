module AccountScopeExtension
  def saldo(selector = Date.today, inclusive = true)
    new_saldo = 0

    for account in all
      new_saldo += account.saldo(selector, inclusive)
    end

    return new_saldo
  end
end

class Account < ActiveRecord::Base
  # Associations
  belongs_to :account_type
  
  has_many :credit_bookings, :class_name => "Booking", :foreign_key => "credit_account_id"
  has_many :debit_bookings, :class_name => "Booking", :foreign_key => "debit_account_id"

  def bookings
    Booking.by_account(id)
  end

  # Aspects
  # Pagination
  cattr_reader :per_page
  @@per_page = 50

  # Scopes
  default_scope :order => 'code'
  
  # Dummy scope to make scoped_by happy
  scope :by_value_period, scoped
  
  scope :current_assets, where('account_type_id = 1') do
    include AccountScopeExtension
  end
  scope :capital_assets, where('account_type_id = 2') do
    include AccountScopeExtension
  end
  scope :outside_capital, where('account_type_id = 3') do
    include AccountScopeExtension
  end
  scope :equity_capital, where('account_type_id = 4') do
    include AccountScopeExtension
  end
  scope :expenses, where('account_type_id = 5') do
    include AccountScopeExtension
  end
  scope :earnings, where('account_type_id = 6') do
    include AccountScopeExtension
  end

  # Validation
  validates_presence_of :code, :title
  
  # Helpers
  def to_s(format = :default)
    "%s (%s)" % [title, code]
  end
  
  # Type support
  def is_asset_account?
    [1, 2, 5].include? account_type_id
  end
  
  def is_liability_account?
    [3, 4, 6].include? account_type_id
  end
  
  # Calculations
  def turnover(selector = Date.today, inclusive = true)
    if selector.is_a? Range or selector.is_a? Array
      if selector.first.is_a? Booking
        equality = "=" if inclusive
        if selector.first.value_date == selector.last.value_date
          condition = ["date(value_date) = :value_date AND id >#{equality} :first_id AND id <#{equality} :last_id", {
            :value_date => selector.first.value_date,
            :first_id => selector.first.id,
            :last_id => selector.last.id
          }]
        else
          condition = ["(value_date > :first_value_date AND value_date < :latest_value_date) OR (date(value_date) = :first_value_date AND id >#{equality} :first_id) OR (date(value_date) = :latest_value_date AND id <#{equality} :last_id)", {
            :first_value_date => selector.first.value_date,
            :latest_value_date => selector.last.value_date,
            :first_id => selector.first.id,
            :last_id => selector.last.id
          }]
        end
      elsif
        # TODO support inclusive param
        condition = {:value_date => selector}
      end
    else
      if selector.is_a? Booking
        equality = "=" if inclusive
        # date(value_date) is needed on sqlite!
        condition = ["(value_date < :value_date) OR (date(value_date) = :value_date AND id <#{equality} :id)", {:value_date => selector.value_date, :id => selector.id}]
      else
        equality = "=" if inclusive
        condition = ["value_date <#{equality} ?", selector]
      end
    end

    credit_amount = credit_bookings.where(condition).sum(:amount)
    debit_amount = debit_bookings.where(condition).sum(:amount)
    
    [credit_amount || 0.0, debit_amount || 0.0]
  end
  
  def saldo(selector = Date.today, inclusive = true)
    credit_amount, debit_amount = turnover(selector, inclusive)

    amount = credit_amount - debit_amount
    
    return is_asset_account? ? amount : -amount
  end
end
