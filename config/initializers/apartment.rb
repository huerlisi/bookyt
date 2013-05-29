Apartment.configure do |config|
  config.excluded_models = ["Tenant", "AdminUser"]
  config.database_names = lambda{ Tenant.pluck(:code) }
end
