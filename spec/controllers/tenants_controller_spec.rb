require 'spec_helper'

describe TenantsController do
  describe "as admin" do
    login_admin
    
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

  describe "as accountant" do
    login_accountant
    
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
end
