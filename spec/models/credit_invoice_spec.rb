require 'spec_helper'

describe CreditInvoice do
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
