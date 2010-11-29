# User factories
require File.expand_path('../roles', __FILE__)
require File.expand_path('../people', __FILE__)

Factory.define :admin_user, :class => User do |f|
  f.email    "admin@example.com"
  f.password "admin1234"
  f.roles [Factory.create(:admin)]
  f.person Factory.build(:person)
end
