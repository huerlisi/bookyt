#Application
set :application, 'bookyt'
set :repository,  'git@github.com:CyTeam/bookyt.git'

# Deployment
set :server, :passenger
set :user, "deployer"                               # The server's user for deploys

set :deploy_to, '/srv/cyt.ch/bookyt'
role :web, "bookyt.cyt"                          # Your HTTP server, Apache/etc
role :app, "bookyt.cyt"                          # This may be the same as your `Web` server
role :db,  "bookyt.cyt", :primary => true        # This is where Rails migrations will run

# Configuration
set :scm, :git
set :branch, "master"
ssh_options[:forward_agent] = true
set :use_sudo, false
set :deploy_via, :remote_cache
set :git_enable_submodules, 1
set :copy_exclude, [".git", "spec"]

# Restart passenger
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

# Bundle install
require "bundler/capistrano"
after "bundle:install", "deploy:migrate"
