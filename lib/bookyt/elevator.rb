class Bookyt::Elevator < Apartment::Elevators::Subdomain
  def parse_database_name(request)
    database_name = super
    if Apartment.database_names.include? database_name
      return database_name
    else
      return nil
    end
  end
end
