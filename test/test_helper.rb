ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  # Add more helper methods to be used by all tests here...
  def assert_similar(expected, actual)
    klass = expected.class
    assert_kind_of klass, actual
    
    field_names = klass.content_columns.collect{|c| c.name}.reject{|name| ["created_at", "updated_at"].include?(name)}
    field_names.each {|field_name|
      assert_equal expected[field_name], actual[field_name], "Attribute '%s' of %s" % [field_name, actual.inspect]
    }
  end
end
