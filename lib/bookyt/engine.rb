module Bookyt
  class Engine
    @@engines = []

    def self.register_engine(name)
      @@engines << name
    end
    
    def self.setup_navigation(navigation, item)
      @@engines.map do |engine|
        self.setup_navigation_engine(navigation, item, engine)
      end
    end

    def self.setup_navigation_engine(navigation, item, name)
      navigation.class.send :include, name.camelize.constantize::Navigation
      navigation.send("setup_#{name}", item)
    end
  end
end
