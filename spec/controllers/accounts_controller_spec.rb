require 'spec_helper'

describe AccountsController do
  after(:each) do
    Account.delete_all
  end

  def mock_account(stubs={})
    @mock_account ||= mock_model(Account, stubs).as_null_object
  end

  context "as admin" do
    login_admin
    
    describe "GET index" do
      it "assigns all accounts as @accounts" do
        @accounts = [Factory.create(:account), Factory.create(:account)]

        get :index

        response.should render_template(:index)
        assigns(:accounts).should eq(@accounts)
      end
    end

    describe "GET show" do
      it "assigns the requested account as @account" do
        @account = Factory.create(:account)
        
        get :show, :id => @account.id

        response.should render_template(:show)
        assigns(:account).should eq(@account)
      end
    end
  end

  context "as accountant" do
    login_accountant

    describe "GET index" do
      it "assigns all accounts as @accounts" do
        @accounts = [Factory.create(:account), Factory.create(:account)]

        get :index

        response.should render_template(:index)
        assigns(:accounts).should eq(@accounts)
      end
    end

    describe "GET show" do
      it "assigns the requested account as @account" do
        @account = Factory.create(:account)

        get :show, :id => @account.id

        response.should render_template(:show)
        assigns(:account).should eq(@account)
      end
    end
  end
end
