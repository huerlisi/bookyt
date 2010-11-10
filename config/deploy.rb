require 'capistrano/ext/multistage'
require 'bundler/capistrano'

set :default_stage, 'example'

set :application, 'bookyt'
set :repository,  'git@github.com:CyTeam/bookyt.git'
set :scm, :git
set :spinner, false
set :deploy_via, :remote_cache
set :copy_exclude, ['**/.git']
set :git_enable_submodules, 1
ssh_options[:forward_agent] = true

#role :web, 'your web-server here'                          # Your HTTP server, Apache/etc
#role :app, 'your app-server here'                          # This may be the same as your `Web` server
#role :db,  'your primary db-server here', :primary => true # This is where Rails migrations will run
#role :db,  'your slave db-server here'

# If you are using Passenger mod_rails uncomment this:
# if you're still using the script/reapear helper you will need
# these http://github.com/rails/irs_process_scripts

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run '#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}'
  end
end

after 'deploy', 'deploy:migrate'
