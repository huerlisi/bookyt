require 'spec_helper'

describe LineItem do
  it { should belong_to :item }
  it { should belong_to :invoice }
  it { should belong_to :booking_template }

  context "when new" do
    subject { LineItem.new }
    its(:total_amount) { should eq(0) }
    its(:times_to_s) { should eq(" x") }
    its(:vat_rate) { should eq("") }
  end
end
