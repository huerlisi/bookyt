before "deploy:setup", "sqlite:setup"
after "db:symlink", "sqlite:symlink"

namespace :sqlite do
  desc "Setup Sqlite3 db"
  task :setup do
    run "mkdir -p #{shared_path}/db"
  end
  
  namespace :sync do
    desc "Sync down the production sqlite database to local development sqlite"
    task :down do
      download "#{shared_path}/db/production.sqlite3", "db/development.sqlite3", :via => :scp
    end

    desc "Sync up the development sqlite database to production sqlite"
    task :up do
      run "mkdir -p #{shared_path}/db"
      upload "db/development.sqlite3", "#{shared_path}/db/production.sqlite3", :via => :scp
    end
  end

  desc "Make symlink for shared database"
  task :symlink do
    run "ln -nfs #{shared_path}/db/#{rails_env}.sqlite3 #{release_path}/db/#{rails_env}.sqlite3"
  end
end
