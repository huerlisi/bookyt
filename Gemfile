# Settings
# ========
source 'http://rubygems.org'

# Rails
# =====
gem 'rails'
gem 'unicorn'

# Database
gem 'mysql2'
gem 'sqlite3'
gem 'pg'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails'
  gem 'sprockets'
  gem 'coffee-rails'
  gem 'uglifier'
  gem 'compass-rails'
end

gem 'jquery-rails'

# Development
# ===========
group :development do
  # RDoc
  gem 'rdoc'

  # UML documentation
  gem 'rails-erd'

  # Haml generators
  gem 'haml-rails'
  gem 'hpricot'
  gem 'ruby_parser'

  # Capistrano
  gem 'capones_recipes'

  # Debugger
  gem 'ruby-debug', :platforms => :ruby_18

  # Console
  gem 'pry-rails'
  gem 'pry-doc'
end

group :test, :development do
  # Framework
  gem 'rspec-rails'

  # Matchers/Helpers
  gem 'shoulda-matchers'

  # Fixtures
  gem 'factory_girl_rails'
  gem 'factory_girl', '< 3.0.0' # For ruby 1.8

  # Browser
  gem 'capybara'

  # Code coverage
  gem 'rcov', :platforms => :ruby_18
  gem 'simplecov', :require => false, :platforms => :ruby_19

  gem 'database_cleaner'
end

group :tools do
  # Zeus
  gem 'zeus'

  # Guard
  gem 'guard-rspec'
  gem 'guard-zeus'

  gem 'rb-inotify'
end

# Standard helpers
# ================
gem 'haml'

# Navigation
gem 'simple-navigation'

# Styling
gem 'lyb_sidebar'
gem 'anjlab-bootstrap-rails', :require => 'bootstrap-rails'
gem 'bootstrap-will_paginate'

# Form framework
gem 'simple_form'
gem 'select2-rails'

# CRUD
gem 'will_paginate'
gem 'inherited_resources'
gem 'has_scope'
gem 'i18n_rails_helpers'
gem 'responders'

# Access Control
gem 'devise'
gem 'omniauth'
gem 'omniauth-google-oauth2'
gem 'faraday'
gem 'cancan'
gem 'lyb_devise_admin'

# Date/Time handling
gem 'validates_timeliness'

gem 'show_for'

# Locale setting
gem 'routing-filter'

# Application Settings
gem 'ledermann-rails-settings', :require => 'rails-settings'

# Bookyt
# ======
# Accounting
gem 'has_accounts'
gem 'has_accounts_engine'

# Addresses
gem 'has_vcards'

# Uploads
gem 'carrierwave'

# In-Place Edit
gem 'best_in_place'

# PDF generation
gem 'pdfkit', :git => 'http://github.com/huerlisi/PDFKit.git'
gem 'wkhtmltopdf-binary'

gem 'prawn'
gem 'prawn_rails'

# Raiffeisen BookingImport
gem 'fastercsv', :platforms => :ruby_18
gem 'csv-mapper'

gem 'mt940_parser', :git => 'http://github.com./CyTeam/mt940_parser.git', :require => 'mt940'

# ESR support
gem 'aasm'
gem 'vesr'

# Search
gem 'thinking-sphinx'

# Tagging
gem 'acts-as-taggable-on'

# Tracking of demo
group :demo do
  gem 'rack-google_analytics'
end

# Plugins
# =======
# Uncomment to enable plugins
gem 'bookyt_pos'
gem 'bookyt_salary'
gem 'bookyt_stock'
gem 'bookyt_projects'

# Monitoring
# ==========
gem 'settingslogic'
group :demo do
  # Traffic
  gem 'rack-google_analytics'

  # Performance
  #gem 'newrelic_rpm'

  # Exceptions
  #gem 'airbrake'
end
