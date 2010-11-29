require 'spec_helper'

describe Invoice do
  context "when new" do
    specify { should_not be_valid }
    its(:to_s) { should == "" }
  end
end
