require 'recipes/rails31'
require 'recipes/database/sync'

namespace :deploy do
  task :cold do       # Overriding the default deploy:cold
    update
    setup_db
    start
  end

  task :setup_db, :roles => :app do
    run "cd #{current_path}; /usr/bin/env bundle exec rake db:setup RAILS_ENV=#{rails_env}"
  end
end

#Application
set :application, 'bookyt'
set :repository,  'git@github.com:huerlisi/bookyt.git'

# Staging
set :stages, %w(staging demo)
set :default_stage, 'staging'

# Deployment
set :server, :passenger
set :user, "deployer"                               # The server's user for deploys

# Configuration
set :scm, :git
set :branch, "master"
ssh_options[:forward_agent] = true
set :use_sudo, false
set :deploy_via, :remote_cache
set :git_enable_submodules, 1
set :copy_exclude, [".git", "spec"]

# Provider
# ========
# Try loading a deploy_provider.rb
begin
  load File.expand_path('../deploy_provider.rb', __FILE__)
rescue LoadError
end

# Plugins
# =======
# Multistaging
require 'capistrano/ext/multistage'
