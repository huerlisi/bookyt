ENV["RAILS_ENV"] ||= 'test'
require File.dirname(__FILE__) + "/../config/environment" unless defined?(Rails.root)
require 'rspec'

Rspec.configure do |c|
  c.mock_with :rspec
end