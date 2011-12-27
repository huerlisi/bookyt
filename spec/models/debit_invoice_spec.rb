require 'spec_helper'

describe DebitInvoice do
  it { should belong_to(:customer) }
  it { should belong_to(:company) }

  it { should validate_presence_of(:customer) }
  it { should validate_presence_of(:company) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:state) }

  describe "as class" do
    subject {DebitInvoice}

    context "without the accounts" do
      its(:direct_account) {should be_nil}
      its(:available_debit_accounts) {should be_empty}
      its(:default_debit_account) {should be_nil}
      its(:available_credit_accounts) {should be_empty}
      its(:default_credit_account) {should be_nil}
    end

    context "with correct accounts loaded" do
      before(:all) do
        [:debit_account, :credit_account, :service_account].each do |name|
          Factory.create(name)
        end
      end

      its(:direct_account) {should == Account.find_by_code('1100')}
      its(:available_debit_accounts) {should_not be_empty}
      its(:default_debit_account) {should == Account.find_by_code('3200')}
      its(:available_credit_accounts) {should_not be_empty}
      its(:default_credit_account) {should == Account.find_by_code('1100')}
    end
  end

  describe "as an instance" do
    subject { Factory.create(:debit_invoice, :due_date => Date.yesterday,
                                             :value_date => Date.yesterday) }

    context "without bookings" do
      its(:balance_account) { should be_nil }
      its(:profit_account) { should be_nil }
    end

    context "changes the state" do
      it "to 'booked' with an amount over 0" do
        subject.bookings << Factory.create(:debit_invoice_booking)
        subject.save

        subject.state.should eq('booked')
      end

      it "to 'paid' with an amount equal 0" do
        subject.bookings << Factory.create(:debit_invoice_booking)
        subject.bookings << Factory.create(:payment_booking)
        subject.save
        subject.reload

        subject.state.should eq('paid')
      end
    end
  end
end