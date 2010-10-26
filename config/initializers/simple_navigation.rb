Dir[File.join(Rails.root, 'lib', 'simple_navigation','renderer', '*.rb')].each{ |patch| require(patch) }

SimpleNavigation.config_file_path = default_config_file_path = Rails.root.join('config', 'navigation')
