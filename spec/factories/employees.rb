# Employee factories

require File.expand_path('../people', __FILE__)

FactoryGirl.define do
  factory :employee, :parent => :person, :class => Employee do
  end
end
