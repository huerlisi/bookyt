namespace :spec do
  desc 'Runs spec with simplecov.'
  Spec::Rake::SpecTask.new('simplecov') do |t|
    puts 'Ensure that the spork server does not run!'
    ENV['COVERAGE'] = 'true'
  end
end
