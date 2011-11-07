class Role < ActiveRecord::Base
  # Associations
  has_and_belongs_to_many :users
  
  validates_presence_of :name

  # Helpers
  def to_s
    name == nil ? "" : I18n.translate(name, :scope => 'cancan.roles')
  end
end
