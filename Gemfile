# Settings
# ========
source 'http://rubygems.org'

# Rails
# =====
gem 'rails', "~> 3.1.0"

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
  gem 'compass', "~> 0.12.alpha.0"
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

  # Fixtures
  gem "factory_girl_rails"

  # Mocking
  # gem 'mocha'

  # Browser
  gem 'capybara'

  # Autotest
  gem 'autotest'
  gem 'autotest-rails'
  gem 'ZenTest', '< 4.6.0' # Keep it working with gems < 1.8
end

group :test, :development do
  # Framework
  gem 'rspec-rails'

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
gem 'formtastic', '1.2.4'
gem 'nested_form', :git => 'https://github.com/ryanb/nested_form.git'

# CRUD
gem 'will_paginate', :git => 'git://github.com/huerlisi/will_paginate.git', :branch => 'rails3'
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
gem 'bookyt_pos'
gem 'bookyt_salary'
gem 'bookyt_stock'
gem 'bookyt_projects'
gem 'vesr'
