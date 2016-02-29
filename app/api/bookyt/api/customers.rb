module Bookyt
  class API
    class Customers < ::Bookyt::API::People
      setup :customers, ::Customer, ::Bookyt::Entities::Person
    end
  end
end
