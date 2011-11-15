require 'spec_helper'

shared_examples "it does all controller actions" do
  context "get the current tenant" do
    it "should have a current_user" do
      subject.current_user.should_not be_nil
    end

    it "redirects to the current tenant" do
      controller.stub(:current_user).and_return(subject.current_user)
      get :current
      response.should redirect_to(current_user.tenant)
    end
  end

  context "get the profit sheet" do
    it "show with the current data" do
      get :profit_sheet
    end
  end

  context "get blance sheet" do
    it "show with the current data" do
      get :balance_sheet
    end
  end
end

describe TenantsController do
  pending "as admin" do
    login_admin
    it_behaves_like "it does all controller actions"
  end

  pending "as accountant" do
    login_accountant
    it_behaves_like "it does all controller actions"
  end
end
