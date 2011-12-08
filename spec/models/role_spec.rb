require 'spec_helper'

describe Role do
  context "when new" do
    specify { should_not be_valid }

    its(:to_s) { should == "" }
  end

  context "admin role" do
    subject { Factory(:admin_role) }

    its(:name) { should =~ /admin/ }
    its(:to_s) { should =~ /Administrator/ }
  end

  context "user role" do
    subject { Factory(:user_role) }

    its(:name) { should =~ /accountant/ }
  end
end
