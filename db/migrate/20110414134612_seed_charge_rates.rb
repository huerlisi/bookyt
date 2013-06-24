# encoding: UTF-8

class SeedChargeRates < ActiveRecord::Migration
  def self.up
    # Salaries
    # ========
    # Charge Rates
    ChargeRate.create!([
      {:code => 'salary:both:ahv_iv_eo', :title => "AHV/IV/EO", :duration_from => '2007-01-01', :rate => 5.05},
      {:code => 'salary:both:ahv_iv_eo', :title => "AHV/IV/EO", :duration_from => '2011-01-01', :rate => 5.15},
      {:code => 'salary:both:alv', :title => "ALV", :duration_from => '2007-01-01', :rate => 1},
      {:code => 'salary:both:alv', :title => "ALV", :duration_from => '2011-01-01', :rate => 1.1},
      {:code => 'salary:both:alv_solidarity', :title => "ALV Solidaritätsprozent", :duration_from => '2011-01-01', :rate => 1},
    ])
  end

  def self.down
  end
end
