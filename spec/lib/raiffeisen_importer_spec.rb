require 'spec_helper'
require 'raiffeisen_importer'

describe RaiffeisenImporter do
  before(:each) do
    @csv_simple = File.dirname(__FILE__) + '/csvs/simple.csv'
    @csv_extended = File.dirname(__FILE__) + '/csvs/extended.csv'
    [:cash_account, :eft_account, :service_account, :cash, :card_turnover].each do |o|
      Factory(o)
    end
  end

  it 'should import data from a simple csv' do
    RaiffeisenImporter::import(@csv_simple)
    @booking = Booking.find_by_value_date('2008-01-03')
    @booking.should_not == nil
    @booking.title.should == 'Bareinzahlung Canonical 81040'
  end
end