require 'spec_helper'

describe ChargeBookingTemplate do
  context "when new" do
    it "should build proper record" do
      @template = ChargeBookingTemplate.new

      expect(@template.charge_rate).to eq(nil)
      expect(@template.amount).to eq(0.0)
      expect(@template.booking_parameters).to eq({
                                               "comments"          => nil,
                                               "debit_account_id"  => nil,
                                               "title"             => nil,
                                               "amount"            => BigDecimal("0"),
                                               "credit_account_id" => nil
                                              })
    end
  end
end
