# encoding: UTF-8

class Admin::Tenant < ActiveRecord::Base
  self.table_name = 'admin_tenants'

  attr_accessible :active, :db_name, :subdomain

  validates :subdomain, :uniqueness => true, :presence => true, :format => /^[a-z][a-z0-9-]*$/
  validates :db_name, :uniqueness => true, :presence => true, :format => /^\w*$/
  validate :db_name, :validate_db_name

  def validate_db_name
    # Guard against homepage hijacking
    if ['www', 'public'].include? subdomain
      errors.add :subdomain, "#{subdomain} ist nicht verfügbar"
    end

    true
  end

  def to_s
    subdomain
  end

  def domain
    subdomain + '.bookyt.ch'
  end
end
