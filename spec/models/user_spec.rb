require 'spec_helper'

describe User do
  before(:all) do
    [:admin_role, :user_role].each do |role|
      FactoryGirl.create(role)
    end
  end

  describe "when new" do
    specify { is_expected.not_to be_valid }
    its(:to_s) { should == "" }
    its(:person) { should be_present }
  end

  describe "as admin" do
    subject { FactoryGirl.create :user_admin }

    describe "should be valid" do
      specify { is_expected.to be_valid }
      specify { is_expected.to be_role(:admin) }
      its(:role_texts) { should == ["admin"] }
    end

    it "should add it to the accountant role" do
      admin = FactoryGirl.create(:user_admin)
      admin.role_texts = ['accountant', 'admin']
      admin.save!
      expect(admin).to be_valid
      expect(admin).to be_role(:accountant)
      expect(admin).to be_role(:admin)
    end
  end

  describe "as accountant" do
    subject { FactoryGirl.create(:user_accountant) }

    describe "should be valid" do
      specify { is_expected.to be_valid }
      specify { is_expected.to be_role(:accountant) }
      specify { is_expected.not_to be_role(:admin) }
    end

    it "should add it to the admin role" do
      accountant = FactoryGirl.create(:user_accountant)
      accountant.role_texts = ['admin', 'accountant']
      accountant.save!
      expect(accountant).to be_valid
      expect(accountant).to be_role(:accountant)
      expect(accountant).to be_role(:admin)
    end
  end
end
