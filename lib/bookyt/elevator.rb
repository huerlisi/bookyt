require 'apartment/elevators/subdomain'

class Bookyt::Elevator < Apartment::Elevators::Subdomain
  def subdomain(request)
    subdomain = super
    if tenant = Admin::Tenant.find_by_subdomain(subdomain)
      return tenant.db_name
    else
      return nil
    end
  end
end
