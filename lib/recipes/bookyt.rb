require 'capones_recipes/tasks/utilities'

after "deploy:finalize_update", "bookyt:symlink"

namespace :bookyt do
  desc "Interactive configuration"
  task :prepare_config, :roles => :app do
    modules = [:pos, :salary, :stock, :projects].inject([]) do |out, pos|
      out << "bookyt_#{pos.to_s}" if Utilities.yes? "Install bookyt_#{pos.to_s}"

      out
    end
    modules = modules.map {|item| "'#{item}'" }.join(', ')
    initializer_template = File.expand_path(File.dirname(__FILE__) + '/templates/bookyt.rb')
    put Utilities.init_file(initializer_template, "<%%>", modules), "#{shared_path}/config/initializers/bookyt.rb"
  end

  desc "Make symlink for shared bookyt initializer"
  task :symlink do
    run "ln -nfs #{shared_path}/config/initializers/bookyt.rb #{release_path}/config/initializers/bookyt.rb"
  end
end
