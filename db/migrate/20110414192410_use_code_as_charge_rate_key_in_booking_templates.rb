class UseCodeAsChargeRateKeyInBookingTemplates < ActiveRecord::Migration
  def self.up
    add_column :booking_templates, :charge_rate_code, :string

    ChargeBookingTemplate.all.map{|template|
      template.charge_rate_code = ChargeRate.find(template.charge_rate_id).code
      template.save
    }
    
    remove_column :booking_templates, :charge_rate_id
  end

  def self.down
  end
end
