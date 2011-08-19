# Settings
# ========
source 'http://rubygems.org'

# Rails
# =====
gem 'rails', '~> 3.1.0.rc'

# Database
gem 'mysql2'
gem 'sqlite3'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails', "~> 3.1.0.rc"
  gem 'sprockets', "~> 2.0.0.beta"
  # gem 'coffee-rails', "~> 3.1.0.rc"
  gem 'therubyracer'
  gem 'uglifier'
  gem 'compass', :git => 'git://github.com/chriseppstein/compass.git', :branch => 'rails31'
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
end

# Test
# ====
group :test do
  # Matchers/Helpers
  gem 'shoulda'

  # Mocking
  # gem 'mocha'

  # Browser
  gem 'capybara'

  # Autotest
  gem 'autotest'
  gem 'autotest-rails'
end

group :test, :development do
  # Framework
  gem 'rspec-rails'

  # Fixtures
  gem "factory_girl_rails"

  # Integration
  # gem 'cucumber-rails'
  # gem 'cucumber'
end

# Standard helpers
# ================
gem 'haml'

# Navigation
gem 'simple-navigation'

# Styling
gem 'lyb_sidebar'

# Form framework
gem 'formtastic'
gem 'nested_form', :git => 'https://github.com/ryanb/nested_form.git'

# CRUD
gem 'will_paginate'
gem 'inherited_resources'
gem 'has_scope'
gem 'i18n_rails_helpers'

# Access Control
gem 'devise'
gem 'cancan'

# Date/Time handling
gem 'validates_timeliness'

gem 'show_for'

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

# Plugins
# =======
# Uncomment to enable plugins
#gem 'bookyt_pos'
#gem 'bookyt_salary'
#gem 'bookyt_stock'
