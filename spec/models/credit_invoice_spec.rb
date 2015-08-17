require 'spec_helper'

describe CreditInvoice do
  context "when new" do
    before(:all) do
      @invoice = CreditInvoice.new
    end

    it "should return an empty string" do
      expect(@invoice.to_s).to eq("")
      expect(@invoice.to_s(:long)).to eq("")
      expect(@invoice.to_s(:reference)).to eq("")
    end
  end
end
