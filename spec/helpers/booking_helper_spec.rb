require 'spec_helper'

describe BookingHelper do
  describe "#reference_types_as_collection" do
    context "returns the reference types" do
      subject { helper.reference_types_as_collection }
      its(["Rechnung"]) { should eq(Invoice.base_class)}
    end
  end
end
