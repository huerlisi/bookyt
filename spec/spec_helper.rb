require 'rubygems'

ENV["RAILS_ENV"] = 'test'

if ENV['COVERAGE']
  require 'simplecov'
  SimpleCov.start 'rails'
end

require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'

# Configure capybara for integration testing
require "capybara/rails"
require 'capybara/poltergeist'

Capybara.configure do |config|
  config.default_driver    = :rack_test
  config.javascript_driver = ENV['JS_DRIVER'] ? ENV['JS_DRIVER'].to_sym : :poltergeist
  config.default_wait_time = ENV['CI'] ? 5 : 5
end

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

# TODO: not sure why this is needed, it's not using the default locale otherwise
I18n.locale = 'de-CH'

RSpec.configure do |config|
  # == Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr
  config.mock_with :rspec

  # Increase log level on CI
  if ENV['CI'] || ENV['TRAVIS']
    Rails.logger.level = 4
  end

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  # config.use_transactional_fixtures = true
  # config.use_transactional_examples = true

  require 'database_cleaner'

  config.use_transactional_fixtures                      = false

  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each, type: :feature) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

  # Devise
  config.include Devise::TestHelpers, :type => :controller
  config.include Devise::TestHelpers, :type => :helper
  config.include Devise::TestHelpers, :type => :view
  config.extend ControllerMacros, :type => :controller
  config.extend ControllerMacros, :type => :helper
  config.extend RequestMacros, :type => :request

  # JSON spec
  config.include JsonSpec::Helpers
end
