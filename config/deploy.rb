require 'capones_recipes/cookbook/rails'
require 'capones_recipes/tasks/thinking_sphinx'

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

# Application
set :application, 'bookyt'
set :repository,  'git@github.com:huerlisi/bookyt.git'

# Staging
set :default_stage, 'staging'

# Deployment
set :server, :passenger
set :user, "deployer"                               # The server's user for deploys

# Sync directories
set :sync_directories, ["system"]
set :sync_backups, 3

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
# Load configuration
config_path = File.expand_path('~/.capones.yml')

if File.exist?(config_path)
  # Parse config file
  config = YAML.load_file(config_path)

  # States
  deploy_target_path = File.expand_path(config['deploy_target_repository']['path'])

  # Add stages
  set :stage_dir, File.join(deploy_target_path, application, 'stages')
  load_paths << ""
end

# Plugins
# =======
# Multistaging
require 'capistrano/ext/multistage'
