set :rails_env, "production"
set :mod_rails_restart_file, "/srv/demo.cyt.ch/bookyt/current/tmp/restart.txt"

set :deploy_to, "/srv/demo.cyt.ch/bookyt"

set :sync_backups, 1
set :keep_releases, 1

set :use_sudo, false
set :apache_init_script, "/etc/init.d/apache2"

role :web, "web03.demo"
role :app, "web03.demo"
role :db,  "web03.demo", :primary => true
