# Application

# Deployment
set :domain, 'cyt.ch'
set :client, 'cyt'

set :rails_env, 'production'
set :branch, "stable"

set :deploy_to, "/srv/#{domain}/#{application}"
role :web, "#{application}.#{client}"                          # Your HTTP server, Apache/etc
role :app, "#{application}.#{client}"                          # This may be the same as your `Web` server
role :db,  "#{application}.#{client}", :primary => true        # This is where Rails migrations will run
