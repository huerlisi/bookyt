We currently support installing on Debian 5.0 Lenny and Ubuntu 12.04
systems.

Install Ruby’n’Rails
--------------------

Bookyt is developed and tested using Rails 3.2 and Ruby 2.2.

Install packages needed:

    sudo apt-get install rubygems irb libruby-extras libxml2-dev libxslt-dev ruby-dev build-essential
    sudo apt-get install git

Then some gems:

    sudo gem install rake bundler

Testing
-------

You currently need phantomjs version 1.8.1 or newer. You can get this on
Ubuntu 13.10.

Install Bookyt
--------------

Install current Bookyt from git repository. We’ll use this checkout as
working directory from now on:

    git clone http://github.com/huerlisi/bookyt.git
    cd bookyt

Install dependency gems:

    bundle

Setup database:

Copy database.yml.example to database.yml and edit as needed.

    cp config/database.yml.example config/database.yml

Initialize the database:

    bundle exec rake db:setup

Configure
---------

There's some settings that are done on an application level like application title and API
keys for external services. These are configured in config/application.yml.

To get started copy the example:

    cp config/application.yml.example config/application.yml
    
## CAS authentication configuration

It could be configurable between `database_authenticatable` and `cas_authenticatable`.
If `cas_authenticatable` being used as `devise_backend`, `cas_base_url` must have to be defined.

For `extra-attribute` configuration Please add `CASExtraAttributesMapper` class in `lib/cas_extra_attributes_mapper.rb`.

Example:

```ruby
class CASExtraAttributesMapper
  def self.call(extra_attributes, user)
    extra_attributes.each do |name, value|
      case name.to_sym
      when :full_name
        # .find_by not works in Rails 3
        user.fullname = value
      when :roles
        user.role_texts = [value.split(',')].flatten
      end
      # And so on for other attributes
    end
  end
end
```

Setup admin user
----------------

There’s a rake task to setup an admin user:

    bundle exec rake users:admin

Create account types
--------------------

Account types need to be named correctly for calculation of the balance
sheet and profit sheet.

See db/seeds/locales for your convenience.

### Run

You should now be able to start Bookyt:

    rails server

Bookyt is now available at http://localhost:3000

Enjoy!
