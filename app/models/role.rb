class Role < ActiveRecord::Base
  # Associations
  has_and_belongs_to_many :users

  # Helpers
  def to_s
    I18n.translate(name, :scope => 'cancan.roles')
  end
end
