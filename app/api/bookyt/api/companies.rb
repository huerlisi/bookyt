module Bookyt
  class API
    class Companies < ::Bookyt::API::People
      setup :companies, ::Company, ::Bookyt::Entities::Person
    end
  end
end
