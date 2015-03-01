module Bookyt
  class Engine
    def self.engines
      # Guard
      return [] unless Tenant.first

      Tenant.first.settings(:modules).active
    end

    def self.setup_navigation(navigation, item)
      self.engines.map do |engine|
        self.setup_navigation_engine(navigation, item, engine)
      end
    end

    def self.setup_navigation_engine(navigation, item, name)
      navigation.class.send :include, name.camelize.constantize::Navigation
      navigation.send("setup_#{name}", item)
    end
  end
end
