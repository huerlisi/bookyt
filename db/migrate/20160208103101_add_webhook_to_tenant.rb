class AddWebhookToTenant < ActiveRecord::Migration
  def change
    add_column :tenants, :webhook, :string
  end
end
