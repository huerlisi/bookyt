class SwitchToSaldoLineItems < ActiveRecord::Migration
  def up
    LineItem.where(:quantity => 'saldo_of').update_all(:type => 'SaldoLineItem', :price => nil)
  end
end
