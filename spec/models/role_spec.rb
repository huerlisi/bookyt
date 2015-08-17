require 'spec_helper'

describe Role do
  context "when new" do
    specify { is_expected.not_to be_valid }

    its(:to_s) { should == "" }
  end

  context "admin role" do
    subject { FactoryGirl.build(:admin_role) }

    its(:name) { should =~ /admin/ }
    its(:to_s) { should =~ /Administrator/ }
  end

  context "user role" do
    subject { FactoryGirl.build(:user_role) }

    its(:name) { should =~ /accountant/ }
  end
end
