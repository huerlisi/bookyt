require 'spec_helper'

describe CreditInvoice do
  context "instance methods" do
    subject {CreditInvoice}
    let!(:cost_account) { Factory.create(:material_account) }
    let!(:credit_account) { Factory.create(:credit_account) }

    its(:direct_account) {should == Account.find_by_code('2000')}

    its(:available_debit_accounts) {should include(credit_account)}
    its(:default_debit_account) {should == Account.find_by_code('2000')}

    its(:available_credit_accounts) {should include(cost_account)}
    its(:default_credit_account) {should == Account.find_by_code('4000')}
  end

  context "when new" do
    before(:all) do
      @invoice = CreditInvoice.new
    end

    it "should return an empty string" do
      @invoice.to_s.should eq("")
      @invoice.to_s(:long).should eq("")
      @invoice.to_s(:reference).should eq("")
    end
  end
end
