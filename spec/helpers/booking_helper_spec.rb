require 'spec_helper'

describe BookingHelper do
  describe "#reference_types_as_collection" do
    it "returns the reference types" do
      allow(helper).to receive(:t_model).and_return('Rechnung')
      expect(helper.reference_types_as_collection).to eq({'Rechnung' => Invoice.base_class})
    end
  end
end
