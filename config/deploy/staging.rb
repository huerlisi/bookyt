# Application
set :instance, "test.#{application}"

# Deployment
set :domain, 'cyt.ch'

set :rails_env, 'staging'
set :branch, "master"

set :deploy_to, "/srv/#{domain}/#{application}"
role :web, "#{instance}"                          # Your HTTP server, Apache/etc
role :app, "#{instance}"                          # This may be the same as your `Web` server
role :db,  "#{instance}", :primary => true        # This is where Rails migrations will run
