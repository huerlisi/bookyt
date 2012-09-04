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
        get :index

        response.should render_template(:index)
      end
    end

    describe "GET show" do
      it "assigns the requested account as @account" do
        @account = Factory.create(:account)

        get :show, :id => @account.id

        response.should render_template(:show)
        assigns(:account).should == @account
        assigns(:bookings).should_not be_nil
      end

      it "assigns the requested account as @account only credit bookings" do
        @account = Factory.create(:account)

        get :show, {:id => @account.id, :only_credit_bookings => true}

        response.should render_template(:show)
        assigns(:account).should == @account
        assigns(:bookings).should_not be_nil
      end

      it "assigns the requested account as @account only debit bookings" do
        @account = Factory.create(:account)

        get :show, {:id => @account.id, :only_debit_bookings => true}

        response.should render_template(:show)
        assigns(:account).should == @account
        assigns(:bookings).should_not be_nil
      end
    end

    describe "GET csv_bookings" do
      it "exports the bookings as csv file." do
        @account_booking = Factory.create(:account_booking)
        get :csv_bookings, {:id => @account_booking.credit_account.id}
        assigns(:account).should_not be_nil
        assigns(:account).should == @account_booking.credit_account
        assigns(:bookings).should_not be_nil
        assigns(:bookings).should_not be_empty
      end
    end
  end

  context "as accountant" do
    login_accountant

    describe "GET index" do
      it "assigns all accounts as @accounts" do
        get :index

        response.should render_template(:index)
      end
    end

    describe "GET show" do
      it "assigns the requested account as @account" do
        @account = Factory.create(:account)

        get :show, :id => @account.id

        response.should render_template(:show)
        assigns(:account).should == @account
      end

      it "assigns the requested account as @account only credit bookings" do
        @account = Factory.create(:account)

        get :show, {:id => @account.id, :only_credit_bookings => true}

        response.should render_template(:show)
        assigns(:account).should == @account
        assigns(:bookings).should_not be_nil
      end

      it "assigns the requested account as @account only debit bookings" do
        @account = Factory.create(:account)

        get :show, {:id => @account.id, :only_debit_bookings => true}

        response.should render_template(:show)
        assigns(:account).should == @account
        assigns(:bookings).should_not be_nil
      end
    end
  end
end
