require 'rubygems'
require 'spork'

ENV["RAILS_ENV"] = 'test'

Spork.prefork do
  require "rails/application"
  # Code snippet from: https://github.com/sporkrb/spork/wiki/Spork.trap_method-Jujutsu
  Spork.trap_method(Rails::Application::RoutesReloader, :reload!)

  require File.expand_path("../../config/environment", __FILE__)
  require 'rspec/rails'

  # Configure capybara for integration testing
  require "capybara/rails"
  Capybara.default_driver   = :rack_test
  Capybara.default_selector = :css

  # Requires supporting ruby files with custom matchers and macros, etc,
  # in spec/support/ and its subdirectories.
  Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

  # Paperclip helper
  require 'paperclip/matchers'

  RSpec.configure do |config|
    # == Mock Framework
    #
    # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
    #
    # config.mock_with :mocha
    # config.mock_with :flexmock
    # config.mock_with :rr
    config.mock_with :rspec

    # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
    config.fixture_path = "#{::Rails.root}/spec/fixtures"

    # If you're not using ActiveRecord, or you'd prefer not to run each of your
    # examples within a transaction, remove the following line or assign false
    # instead of true.
    config.use_transactional_fixtures = true

    # Paperclip
    config.include Paperclip::Shoulda::Matchers

    # Devise
    config.include Devise::TestHelpers, :type => :controller
    config.include Devise::TestHelpers, :type => :helper
    config.extend ControllerMacros, :type => :controller
    config.extend ControllerMacros, :type => :helper
  end

  require 'database_cleaner'
  DatabaseCleaner.strategy = :truncation

  # Thinking Sphinx integration
  require 'thinking_sphinx/test'
  ThinkingSphinx::Test.init
end

Spork.each_run do
  DatabaseCleaner.clean
  FactoryGirl.reload
  I18n.backend.reload!
end
