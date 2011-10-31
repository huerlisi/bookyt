# encoding: utf-8

$:.unshift File.expand_path('../lib', __FILE__)
require 'bookyt/version'

Gem::Specification.new do |s|
  s.name         = "bookyt"
  s.version      = Bookyt::VERSION
  s.authors      = ["Simon Hürlimann", "Roman Simecek"]
  s.email        = ["simon.huerlimann@cyt.ch", "roman.simecek@cyt.ch"]
  s.homepage     = "https://github.com/raskhadafi/bookyt"
  s.summary      = "financial accounting software"
  s.description  = "bookyt is a simple but powerfull financial accounting software."

  s.files        = `git ls-files app lib`.split("\n")
  s.platform     = Gem::Platform::RUBY
  s.require_path = 'lib'
  s.rubyforge_project = '[none]'
end
