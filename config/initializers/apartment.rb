Apartment.configure do |config|
  config.excluded_models = ["Admin::Tenant", "AdminUser"]
  config.tenant_names = lambda{ Admin::Tenant.pluck(:db_name) }
end
