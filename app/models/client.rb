class Client < ActiveRecord::Base
  # Associations
  has_many :accounts

  # Helpers
  def to_s
    name
  end
end
