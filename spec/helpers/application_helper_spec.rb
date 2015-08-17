require 'spec_helper'

shared_examples "current_tenant" do
  context "current_tenant" do
    it "returns the current tenant" do
      expect(helper.current_tenant).to eq(@current_user.tenant)
    end
  end
end

describe ApplicationHelper do
  context "as admin" do
    login_admin
    it_behaves_like "current_tenant"
  end


  context "as accountant" do
    login_accountant
    it_behaves_like "current_tenant"
  end
end
