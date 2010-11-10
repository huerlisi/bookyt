set :user, 'user_for_deployement'
set :branch, 'master'

set :rails_env, 'production'
set :mod_rails_restart_file, '/path_to_root/current/tmp/restart.txt'

set :deploy_to, '/path_to_root'

set :sync_backups, 1
set :keep_releases, 1

set :use_sudo, false
set :apache_init_script, '/etc/init.d/apache2'

role :web, 'server_name'                        # Your HTTP server, Apache/etc
role :app, 'application_server_name'            # This may be the same as your `Web` server
role :db,  'db_server_name', :primary => true   # This is where Rails migrations will run
