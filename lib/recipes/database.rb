require 'erb'

before "deploy:setup", :db
after "deploy:update_code", "db:symlink"

namespace :db do
  desc "Create database yaml in capistrano shared path"
  task :default do
    db_config = ERB.new <<-EOF
sqlite: &sqlite
  adapter: sqlite3
  pool: 5
  timeout: 5000

mysql: &mysql
  adapter: mysql
  pool: 5
  timeout: 5000
  host: localhost
  username: USER HERE
  password: PASSWORD HERE
  encoding: utf8

development:
  database: #{application}_development
  <<: *sqlite

test:
  database: #{application}_test
  <<: *sqlite

staging:
  database: #{application}_staging
  <<: *sqlite

production:
  database: #{application}_production
  <<: *base
    EOF

    run "mkdir -p #{shared_path}/config"
    put db_config.result, "#{shared_path}/config/database.yml"
  end

  desc "Make symlink for shared database yaml"
  task :symlink do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  end
end
