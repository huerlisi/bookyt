require 'spec_helper'

describe LineItem do
  it { should belong_to :item }
  it { should belong_to :invoice }

  context "when new" do
    its(:total_amount) { should == 0 }

    pending "translations are missing" do
      its(:times_to_s) { should == "" }
    end
  end
end
