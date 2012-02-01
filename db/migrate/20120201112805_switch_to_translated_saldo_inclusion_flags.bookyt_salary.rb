# This migration comes from bookyt_salary (originally 20120201104444)
class SwitchToTranslatedSaldoInclusionFlags < ActiveRecord::Migration
  def up
    ActsAsTaggableOn::Tag.where(:name => 'ahv').update_all(:name => 'AHV')
    ActsAsTaggableOn::Tag.where(:name => 'ktg').update_all(:name => 'KTG')
    ActsAsTaggableOn::Tag.where(:name => 'gross_income').update_all(:name => 'Bruttolohn')
    ActsAsTaggableOn::Tag.where(:name => 'net_income').update_all(:name => 'Nettolohn')
    ActsAsTaggableOn::Tag.where(:name => 'payment').update_all(:name => 'Auszahlung')
    ActsAsTaggableOn::Tag.where(:name => 'uvg').update_all(:name => 'UVG')
    ActsAsTaggableOn::Tag.where(:name => 'uvgz').update_all(:name => 'UVGZ')
    ActsAsTaggableOn::Tag.where(:name => 'deduction_at_source').update_all(:name => 'Quellensteuer')

    SalaryBookingTemplate.where(:amount_relates_to => 'ahv').update_all(:amount_relates_to => 'AHV')
    SalaryBookingTemplate.where(:amount_relates_to => 'ktg').update_all(:amount_relates_to => 'KTG')
    SalaryBookingTemplate.where(:amount_relates_to => 'gross_income').update_all(:amount_relates_to => 'Bruttolohn')
    SalaryBookingTemplate.where(:amount_relates_to => 'net_income').update_all(:amount_relates_to => 'Nettolohn')
    SalaryBookingTemplate.where(:amount_relates_to => 'payment').update_all(:amount_relates_to => 'Auszahlung')
    SalaryBookingTemplate.where(:amount_relates_to => 'uvg').update_all(:amount_relates_to => 'UVG')
    SalaryBookingTemplate.where(:amount_relates_to => 'uvgz').update_all(:amount_relates_to => 'UVGZ')
    SalaryBookingTemplate.where(:amount_relates_to => 'deduction_at_source').update_all(:amount_relates_to => 'Quellensteuer')
  end
end
