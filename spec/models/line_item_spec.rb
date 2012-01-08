require 'spec_helper'

describe LineItem do
  it { should belong_to :item }
  it { should belong_to :invoice }
  it { should belong_to :debit_account }
  it { should belong_to :credit_account }

  context "when new" do
    describe "blank attributes" do
      subject { LineItem.new }
      its(:total_amount) { should eq(0) }
      its(:times_to_s) { should eq(" x") }
      its(:vat_rate) { should eq(0) }
    end

    describe "with x quantity" do
      subject { LineItem.new(:quantity => 'x', :times => 1, :price => 12.25) }
      its(:times) { should eq(1) }
      its(:times_to_s) { should eq('') }
      its(:vat_rate) { should eq(0) }
      its(:total_amount) { should eq(12.25) }
      its(:price) { should eq(12.25) }
    end

    describe "with overall quantity" do
      subject { LineItem.new(:quantity => 'overall', :times => 1, :price => 12.25) }
      its(:times) { should eq(1) }
      its(:times_to_s) { should eq(I18n::translate('line_items.quantity.overall')) }
      its(:vat_rate) { should eq(0) }
      its(:total_amount) { should eq(12.25) }
      its(:price) { should eq(12.25) }
    end

    describe "without quantity" do
      subject { LineItem.new(:quantity => 'hours', :times => 1.0, :price => 12.25) }
      its(:times) { should eq(1) }
      its(:times_to_s) { should eq("1.0 #{I18n::translate('line_items.quantity.hours')}") }
      its(:vat_rate) { should eq(0) }
      its(:total_amount) { should eq(12.25) }
      its(:price) { should eq(12.25) }
    end
  end
end
