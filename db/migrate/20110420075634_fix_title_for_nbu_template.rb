class FixTitleForNbuTemplate < ActiveRecord::Migration
  def self.up
    ChargeBookingTemplate.update_all("title = 'NBU Arbeitnehmer'", "title = 'NBU Arbeitnehmner'")
  end

  def self.down
  end
end
