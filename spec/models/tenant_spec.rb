require 'spec_helper'

describe Tenant do
  it { should belong_to :company }
  
  it { should validate_presence_of :company }
  #it { should validate_date :incorporated_on } # TODO: This validations can be checked at the moment
  
  context "when new" do
    specify { should_not be_valid }
    
    its(:to_s) { should == "" }
  end
  
  context "when properly initialized" do
    subject { Factory.build :tenant }

    its(:to_s) { should =~ /Muster Peter/ }
  end
end
