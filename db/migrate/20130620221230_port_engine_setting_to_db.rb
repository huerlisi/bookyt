class PortEngineSettingToDb < ActiveRecord::Migration
  def up
    # Guard
    return unless Rails.root.join('config', 'initializers', 'bookyt.rb').exist?

    tenant = Tenant.first
    tenant.settings['modules.enabled'] = Bookyt::Application.config.bookyt.engines

    tenant.save
  end
end
