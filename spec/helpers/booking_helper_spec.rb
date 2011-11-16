require 'spec_helper'

describe BookingHelper do
  describe "#reference_types_as_collection" do
    it "returns the reference types" do
      helper.stub(:t_model).and_return('Rechnung')
      subject { helper.reference_types_as_collection }
      subject { should eq(Invoice.base_class)}
    end
  end
end
