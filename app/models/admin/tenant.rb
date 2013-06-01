class Admin::Tenant < ActiveRecord::Base
  self.table_name = 'admin_tenants'

  attr_accessible :active, :db_name, :subdomain

  validates :subdomain, :uniqueness => true, :presence => true

  def to_s
    subdomain
  end
end
