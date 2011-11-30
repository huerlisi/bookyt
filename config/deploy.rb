# Application
set :application, 'bookyt'
set :repository,  'git@github.com:huerlisi/bookyt.git'

require 'capones_recipes/cookbook/rails'
require 'capones_recipes/tasks/thinking_sphinx'
require 'capones_recipes/tasks/carrier_wave'

load 'deploy/assets'

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

# Staging
set :default_stage, 'staging'

# Deployment
set :server, :passenger
set :user, "deployer"                               # The server's user for deploys

# Sync directories
set :sync_directories, ['uploads']
set :sync_backups, 3

# Configuration
set :scm, :git
set :branch, "master"
ssh_options[:forward_agent] = true
set :use_sudo, false
set :deploy_via, :remote_cache
set :git_enable_submodules, 1
set :copy_exclude, [".git", "spec"]
