# Settings
# ========
source 'http://rubygems.org'

# Rails
# =====
gem 'rails', '~> 3.2.14' # Because it makes sense, and bundler fails otherwise
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
group :production do
  gem 'therubyracer'
end

gem 'jquery-rails'
gem 'jquery-ui-rails'

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
  gem 'capistrano-rbenv'

  # Development Server
  gem 'webrick'
  gem 'quiet_assets'
end

group :test, :development do
  # Framework
  gem 'rspec-rails'

  # Matchers/Helpers
  gem 'shoulda-matchers'
  gem 'json_spec'

  # Fixtures
  gem 'factory_girl_rails'
  gem 'database_cleaner'

  # Browser
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'poltergeist'

  # Code coverage
  gem 'rcov', :platforms => :ruby_18
  gem 'simplecov', :require => false, :platforms => :ruby_19

  # Console
  gem 'pry-rails'
  gem 'pry-doc'
  gem 'pry-byebug'
end

# Standard helpers
# ================
gem 'haml'

# Navigation
gem 'simple-navigation'

# Styling
gem 'lyb_sidebar'
gem 'anjlab-bootstrap-rails', '~>2.1.0', :require => 'bootstrap-rails'
gem 'bootstrap-datepicker-rails'
gem 'bootstrap-will_paginate'

# Form framework
gem 'simple_form'
gem 'select2-rails'

# CRUD
gem 'will_paginate'
gem 'inherited_resources'
gem 'has_scope'
gem 'i18n_rails_helpers', '~> 2.0.0.beta0'
gem 'responders'

# Access Control
gem 'devise', '~>3.0.4'
gem 'omniauth'
gem 'omniauth-google-oauth2'
gem 'faraday'
gem 'cancan', '1.6.8' # issue regarding alias and real action name
gem 'lyb_devise_admin'
gem 'apartment'

# API
gem 'versionist'
gem 'active_model_serializers'

gem 'api_taster', '0.6.0'

# Data dump/restore
gem 'yaml_db'

# Date/Time handling
gem 'validates_timeliness'

gem 'show_for'

# Locale setting
gem 'routing-filter'

# Application Settings
gem 'ledermann-rails-settings', '~> 1.1.0', :require => 'rails-settings' # incompatible changes

# Bookyt
# ======
# Accounting
gem 'has_accounts', github: 'huerlisi/has_accounts'
gem 'has_accounts_engine', '~> 3.0.0.beta2'

# Addresses
gem 'has_vcards', '~> 1.0.0.rc0'

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

gem 'mt940_parser', :git => 'http://github.com/CyTeam/mt940_parser.git', :require => 'mt940'

# ESR support
gem 'aasm'
gem 'vesr'

# Search
gem 'pg_search'

# Tagging
gem 'acts-as-taggable-on', '~> 2.4.1'

# Plugins
# =======
# Uncomment to enable plugins
gem 'bookyt_pos'
gem 'bookyt_salary', github: 'huerlisi/bookyt_salary'
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
