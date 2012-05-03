# This migration comes from bookyt_salary (originally 20120201125113)
class SwitchLineItemsToTranslatedSaldoInclusionFlags < ActiveRecord::Migration
  def up
    LineItem.where(:reference_code => 'ahv').update_all(:reference_code => 'AHV')
    LineItem.where(:reference_code => 'ktg').update_all(:reference_code => 'KTG')
    LineItem.where(:reference_code => 'gross_income').update_all(:reference_code => 'Bruttolohn')
    LineItem.where(:reference_code => 'net_income').update_all(:reference_code => 'Nettolohn')
    LineItem.where(:reference_code => 'payment').update_all(:reference_code => 'Auszahlung')
    LineItem.where(:reference_code => 'uvg').update_all(:reference_code => 'UVG')
    LineItem.where(:reference_code => 'uvgz').update_all(:reference_code => 'UVGZ')
    LineItem.where(:reference_code => 'deduction_at_source').update_all(:reference_code => 'Quellensteuer')
  end
end
