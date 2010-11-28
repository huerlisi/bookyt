require 'spec_helper'

describe User do
  context "when new" do
    specify { should_not be_valid }
    its(:to_s) { should == "" }
    its(:current_company) { should be_nil }
  end
  
  context "when an admin" do
    subject { Factory.create :admin_user }
    
    specify { should be_valid }
    specify { should be_role(:admin) }
    its(:role_texts) { should == ["admin"] }
  end
end
