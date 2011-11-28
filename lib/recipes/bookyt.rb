before "deploy:setup", "bookyt:setup"
after "deploy:finalize_update", "bookyt:symlink"

namespace :bookyt do
  desc "Create bookyt config initializer in capistrano shared path"
  task :setup do
    run "mkdir -p #{shared_path}/config/initializers"
    upload "config/initializers/bookyt.rb.example", "#{shared_path}/config/initializers/bookyt.rb", :via => :scp
  end

  desc "Make symlink for config initializer"
  task :symlink do
    run "ln -nfs #{shared_path}/config/initializers/bookyt.rb #{release_path}/config/initializers/bookyt.rb"
    run "ln -nfs #{shared_path}/system #{release_path}/system"
  end
end
