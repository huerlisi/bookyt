class AccountType < ActiveRecord::Base
  # Helpers
  def to_s
    title
  end
end
