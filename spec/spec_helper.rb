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

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

RSpec.configure do |config|
  # == Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr
  config.mock_with :rspec

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  # config.use_transactional_fixtures = true
  # config.use_transactional_examples = true

  require 'database_cleaner'
  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
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
  config.extend ControllerMacros, :type => :controller
  config.extend ControllerMacros, :type => :helper
end

# Thinking Sphinx integration
require 'thinking_sphinx/test'
ThinkingSphinx::Test.init
