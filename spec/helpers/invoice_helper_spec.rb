require 'spec_helper'

describe InvoiceHelper do
  describe "#invoice_states_as_collection" do
    it "returns invoice states" do
      expect(helper.invoice_states_as_collection).to eq({"storniert" => "canceled",
                                                     "offen" => "booked",
                                                     "3x gemahnt" => "3xreminded",
                                                     "abgeschrieben" => "written_off",
                                                     "2x gemahnt" => "2xreminded",
                                                     "reaktiviert" => "reactivated",
                                                     "in Inkasso" => "encashment",
                                                     "1x gemahnt" => "reminded",
                                                     "bezahlt" => "paid"})
    end
  end
end
