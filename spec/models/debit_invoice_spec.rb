require 'spec_helper'

describe DebitInvoice do
  it { should belong_to(:customer) }
  it { should belong_to(:company) }

  it { should validate_presence_of(:customer) }
  it { should validate_presence_of(:company) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:state) }

  describe "as class" do
    context "without the accounts" do
      subject { DebitInvoice }

      it "returns the direct account" do
        subject.direct_account.should be_nil
      end

      it "returns the avaible contra accounts" do
        subject.available_contra_accounts.should be_empty
      end

      it "returns the default contra account" do
        subject.default_contra_account.should be_nil
      end
    end

    context "with correct accounts loaded" do
      before(:all) do
        [:account_1100, :credit_account, :service_account].each do |name|
          Factory.create(name)
        end
      end

      subject { DebitInvoice }

      it "returns the direct account" do
        subject.direct_account.code.should eq('1100')
      end

      it "returns the avaible contra accounts" do
        subject.available_contra_accounts.should_not be_empty
      end

      it "returns the default contra account" do
        subject.default_contra_account.code.should eq('3200')
      end
    end
  end

  describe "as an instance" do
    subject { Factory.create(:debit_invoice, :due_date => Date.yesterday,
                                             :value_date => Date.yesterday) }

    context "without bookings" do
      its(:balance_account) { should be_nil }
      its(:profit_account) { should be_nil }
    end

    context "does a booking" do
      it "as booked" do
        subject.booking_saved(Factory.create(:booked_booking))
        subject.state.should eq('booked')
      end

      it "as paid" do
        subject.amount = 0.0
        subject.booking_saved(Factory.create(:paid_booking))
        subject.state.should eq('paid')
      end
    end
  end
end