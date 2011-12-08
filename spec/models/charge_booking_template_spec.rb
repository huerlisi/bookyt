require 'spec_helper'

describe ChargeBookingTemplate do
  context "when new" do
    @template = ChargeBookingTemplate.new

    @template.charge_rate.should == nil
    @template.amount.should == 0.0
    @template.booking_parameters.should == {"comments" => nil,
                                            "debit_account_id" => nil,
                                            "title" => nil,
                                            "amount" => nil,
                                            "credit_account_id" => nil}
  end
end