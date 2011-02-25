before "deploy:setup", :db
after "deploy:update_code", "db:symlink"

namespace :db do
  desc "Create database yaml in capistrano shared path"
  task :default do
    run "mkdir -p #{shared_path}/config"
    upload "config/database.yml.example", "#{shared_path}/config/database.yml", :via => :scp
  end

  desc "Make symlink for shared database yaml"
  task :symlink do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  end
end
