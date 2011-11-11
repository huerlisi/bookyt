require 'spec_helper'

describe TenantsController do
  shared_examples "it does all controller actions" do
    describe "GET current" do
      it "get the current tenant" do
        get :current
        assigns(:tenant).should eq(subject.current_user.tenant)
      end

      pending "get the profit sheet" do
        get :profit_sheet
      end

      pending "get blance sheet" do
        get :balance_sheet
      end
    end
  end

  describe "as admin" do
    login_admin
    it_behaves_like "it does all controller actions"
  end

  describe "as accountant" do
    login_accountant
    it_behaves_like "it does all controller actions"
  end
end
