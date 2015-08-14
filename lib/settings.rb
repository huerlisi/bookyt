class Settings < Settingslogic
  config = Rails.root.join('config', 'application.yml')

  if config.exist?
    source config
  else
    source Rails.root.join('config', 'application.yml.example')
  end

  namespace Rails.env
end
