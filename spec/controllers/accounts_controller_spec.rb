require 'spec_helper'

describe AccountsController do
  login_admin
  
  def mock_account(stubs={})
    @mock_account ||= mock_model(Account, stubs).as_null_object
  end

  describe "GET index" do
    pending "assigns all accounts as @accounts" do
      Account.stub(:all) { [mock_account] }
      get :index
      assigns(:accounts).should eq([mock_account])
    end
  end

  describe "GET show" do
    it "assigns the requested account as @account" do
      pending "Problems with mock_model."

      Account.stub(:find).with("37") { mock_account }
      get :show, :id => "37"
      assigns(:account).should be(mock_account)
    end
  end

  describe "GET new" do
    it "assigns a new account as @account" do
      Account.stub(:new) { mock_account }
      get :new
      assigns(:account).should be(mock_account)
    end
  end

  describe "GET edit" do
    it "assigns the requested account as @account" do
      Account.stub(:find).with("37") { mock_account }
      get :edit, :id => "37"
      assigns(:account).should be(mock_account)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created account as @account" do
        Account.stub(:new).with({'these' => 'params'}) { mock_account(:save => true) }
        post :create, :account => {'these' => 'params'}
        assigns(:account).should be(mock_account)
      end

      it "redirects to the created account" do
        Account.stub(:new) { mock_account(:save => true) }
        post :create, :account => {}
        response.should redirect_to(account_url(mock_account))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved account as @account" do
        Account.stub(:new).with({'these' => 'params'}) { mock_account(:save => false) }
        post :create, :account => {'these' => 'params'}
        assigns(:account).should be(mock_account)
      end

      it "re-renders the 'new' template" do
        Account.stub(:new) { mock_account(:save => false) }
        post :create, :account => {}
        response.should render_template("new")
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested account" do
        Account.should_receive(:find).with("37") { mock_account }
        mock_account.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :account => {'these' => 'params'}
      end

      it "assigns the requested account as @account" do
        Account.stub(:find) { mock_account(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:account).should be(mock_account)
      end

      it "redirects to the account" do
        Account.stub(:find) { mock_account(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(account_url(mock_account))
      end
    end

    describe "with invalid params" do
      it "assigns the account as @account" do
        Account.stub(:find) { mock_account(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:account).should be(mock_account)
      end

      it "re-renders the 'edit' template" do
        Account.stub(:find) { mock_account(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested account" do
      Account.should_receive(:find).with("37") { mock_account }
      mock_account.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the accounts list" do
      Account.stub(:find) { mock_account }
      delete :destroy, :id => "1"
      response.should redirect_to(accounts_url)
    end
  end

end
