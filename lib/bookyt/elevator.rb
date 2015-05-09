require 'apartment/elevators/subdomain'

class Bookyt::Elevator < Apartment::Elevators::Subdomain
  def subdomain(request)
    subdomain = super
    if tenant = Admin::Tenant.where(subdomain: subdomain).first
      return tenant.db_name
    else
      return nil
    end
  end
end
