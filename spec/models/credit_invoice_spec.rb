require 'spec_helper'

describe CreditInvoice do
  context "instance methods" do
    it "should have a direct account" do
      CreditInvoice.direct_account.should be(Account.find_by_code('2000'))
    end

    it "should have a default contra account" do
      CreditInvoice.default_contra_account.should be(Account.find_by_code('4000'))
    end

    pending "should have contra accounts" do
      CreditInvoice.available_contra_accounts.should =~ [Account.find_by_type('costs'),
                                                   Account.find_by_type('current_assets'),
                                                   Account.find_by_type('capital_assets')]
    end
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