require 'spec_helper'

shared_examples "it does all controller actions" do
  describe "get the current tenant" do
    it "should have a current_user" do
      subject.current_user.should_not be_nil
    end

    it "redirects to the current tenant" do
      controller.stub(:current_user).and_return(@current_user)
      get :current
      response.should redirect_to(@current_user.tenant)
    end
  end

  describe "get the profit sheet" do
    it "without params" do
      end_date = Date.today
      start_date = end_date.to_time.advance(:years => -1, :days => 1).to_date
      get :profit_sheet, :id => @current_user.tenant.id
      response.should render_template('profit_sheet')
      assigns(:company).should eq(@current_user.tenant.company)
      assigns(:end_date).should eq(end_date)
      assigns(:start_date).should eq(start_date)
      assigns(:dates).should eq([start_date..end_date])
    end

    it "of a custom period" do
      end_date = Date.today
      start_date = end_date.to_time.advance(:days => -14).to_date
      get :profit_sheet, {:id => @current_user.tenant.id, :by_value_period => {:from => start_date, :to => end_date}}
      response.should render_template('profit_sheet')
      assigns(:company).should eq(@current_user.tenant.company)
      assigns(:end_date).should eq(end_date)
      assigns(:start_date).should eq(start_date)
      assigns(:dates).should eq([start_date..end_date])
    end

    it "of a fiscal year" do
      years = [Date.today.year]
      period = @current_user.tenant.fiscal_period(Date.today.year.to_i)
      get :profit_sheet, {:id => @current_user.tenant.id, :years => years}
      response.should render_template('profit_sheet')
      assigns(:company).should eq(@current_user.tenant.company)
      assigns(:dates).should eq([period[:from]..period[:to]])
    end
  end

  describe "get blance sheet" do
    it "without params" do
      get :balance_sheet, :id => @current_user.tenant.id
      response.should render_template('balance_sheet')
      assigns(:company).should eq(@current_user.tenant.company)
      assigns(:dates).should eq([Date.today])
    end

    it "of a custom period" do
      to_date = Date.today
      get :balance_sheet,{:id => @current_user.tenant.id, :by_value_period => {:to => to_date}}
      response.should render_template('balance_sheet')
      assigns(:company).should eq(@current_user.tenant.company)
      assigns(:dates).should eq([to_date])
    end

    it "of a fiscal year" do
      to_date = Date.today
      years = [@current_user.tenant.fiscal_period(Date.today.year.to_i)[:to]]
      get :balance_sheet,{:id => @current_user.tenant.id, :years => [Date.today.year]}
      response.should render_template('balance_sheet')
      assigns(:company).should eq(@current_user.tenant.company)
      assigns(:dates).should eq(years)
    end
  end
end

describe TenantsController do
  context "as admin" do
    login_admin
    it_behaves_like "it does all controller actions"
  end

  context "as accountant" do
    login_accountant
    it_behaves_like "it does all controller actions"
  end
end
