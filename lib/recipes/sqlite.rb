namespace :sqlite do
  namespace :sync do
    desc "Sync down the production sqlite database to local development sqlite"
    task :down do
      run "mkdir -p #{shared_path}/db"
      download "#{deploy_to}/shared/db/production.sqlite3", "db/development.sqlite3", :via => :scp
    end

    desc "Sync up the development sqlite database to production sqlite"
    task :up do
      upload "db/development.sqlite3", "#{deploy_to}/shared/db/production.sqlite3", :via => :scp
    end
  end
end
