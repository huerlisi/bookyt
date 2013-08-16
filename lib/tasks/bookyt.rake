namespace :bookyt do
  desc "Set up database.yml on travis"
  task :travis do
    ['database'].each do |file|
      example_file = Rails.root.join('config',"#{file}.yml.travis-ci")
      real_file    = Rails.root.join('config',"#{file}.yml")

      if ! File.exists?(real_file)
        sh "cp #{example_file} #{real_file}"
      else
        puts "#{real_file} already exists!"
      end
    end
  end
end
