# Settings
# ========
source 'http://rubygems.org'

# Rails
# =====
gem 'rails', "~> 3.2.0"

# Database
gem 'mysql2'
gem 'sqlite3'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails'
  gem 'sprockets'
  gem 'coffee-rails'
  gem 'therubyracer'
  gem 'uglifier'
  gem 'compass-rails'
  gem 'fancy-buttons'
end

gem 'jquery-rails'

# Development
# ===========
group :development do
  # RDoc
  gem 'rdoc'

  # Haml generators
  gem 'haml-rails'
  gem 'hpricot'
  gem 'ruby_parser'

  # Capistrano
  gem 'capones_recipes'

  # Debugger
  gem 'ruby-debug'
end

group :test, :development do
  # Framework
  gem 'rspec-rails'

  # Integration
  # gem 'cucumber-rails'
  # gem 'cucumber'

    # Matchers/Helpers
  gem 'shoulda'

  # Fixtures
  gem "factory_girl_rails"
  gem "factory_girl", '< 3.0.0' # For ruby 1.8

  # Mocking
  # gem 'mocha'

  # Browser
  gem 'capybara'

  # Autotest
  gem 'autotest'
  gem 'autotest-rails'
  gem 'ZenTest', '< 4.6.0' # Keep it working with gems < 1.8

  # Code coverage
  gem 'rcov', :platforms => :ruby_18
  gem 'simplecov', :require => false, :platforms => :ruby_19

  gem 'spork', '>=0.9.0.rc2'
  gem 'database_cleaner'
  gem 'rspec-instafail'
end

# Standard helpers
# ================
gem 'haml'

# Navigation
gem 'simple-navigation'

# Styling
gem 'lyb_sidebar'
gem 'twitter-bootstrap-rails'
gem 'formtastic-bootstrap'
gem 'bootstrap-will_paginate'

# Form framework
gem 'formtastic'

# CRUD
gem 'will_paginate'
gem 'inherited_resources'
gem 'has_scope'
gem 'i18n_rails_helpers'
gem 'responders'

# Access Control
gem 'devise'
gem 'cancan'

# Date/Time handling
gem 'validates_timeliness'

gem 'show_for'

# Locale setting
gem 'routing-filter'

# Bookyt
# ======
# Accounting
gem 'has_accounts'

# Addresses
gem 'has_vcards'

# Uploads
gem 'carrierwave'

# PDF generation
gem 'pdfkit', :git => 'http://github.com/huerlisi/PDFKit.git'
gem 'wkhtmltopdf-binary'

gem 'prawn'
gem 'prawn_rails'

# Raiffeisen BookingImport
gem 'remotipart'
gem 'paperclip'
gem 'csv-mapper'

# ESR support
gem 'aasm'
gem 'vesr'

# Search
gem 'thinking-sphinx', :git => 'https://github.com/huerlisi/thinking-sphinx.git'

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
