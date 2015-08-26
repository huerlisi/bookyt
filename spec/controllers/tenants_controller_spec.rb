require 'spec_helper'

shared_examples "it does all controller actions" do
  describe "get the profit sheet" do
    it "without params" do
      end_date = Date.today
      start_date = end_date.to_time.advance(:years => -1, :days => 1).to_date
      get :profit_sheet, :id => @current_user.tenant.id
      expect(response).to render_template('profit_sheet')
      expect(assigns(:company)).to eq(@current_user.tenant.company)
      expect(assigns(:end_date)).to eq(end_date)
      expect(assigns(:start_date)).to eq(start_date)
      expect(assigns(:dates)).to eq([start_date..end_date])
    end

    it "of a custom period" do
      end_date = Date.today
      start_date = end_date.to_time.advance(:days => -14).to_date
      get :profit_sheet, {:id => @current_user.tenant.id, :by_date => {:from => start_date, :to => end_date}}
      expect(response).to render_template('profit_sheet')
      expect(assigns(:company)).to eq(@current_user.tenant.company)
      expect(assigns(:end_date)).to eq(end_date)
      expect(assigns(:start_date)).to eq(start_date)
      expect(assigns(:dates)).to eq([start_date..end_date])
    end

    it "of a fiscal year" do
      years = [Date.today.year]
      period = @current_user.tenant.fiscal_period(Date.today.year.to_i)
      get :profit_sheet, {:id => @current_user.tenant.id, :years => years}
      expect(response).to render_template('profit_sheet')
      expect(assigns(:company)).to eq(@current_user.tenant.company)
      expect(assigns(:dates)).to eq([period[:from]..period[:to]])
    end
  end

  describe "get blance sheet" do
    it "without params" do
      get :balance_sheet, :id => @current_user.tenant.id
      expect(response).to render_template('balance_sheet')
      expect(assigns(:company)).to eq(@current_user.tenant.company)
      expect(assigns(:dates)).to eq([Date.today])
    end

    it "of a custom period" do
      to_date = Date.today
      get :balance_sheet,{:id => @current_user.tenant.id, :by_date => {:to => to_date}}
      expect(response).to render_template('balance_sheet')
      expect(assigns(:company)).to eq(@current_user.tenant.company)
      expect(assigns(:dates)).to eq([to_date])
    end

    it "of a fiscal year" do
      to_date = Date.today
      years = [@current_user.tenant.fiscal_period(Date.today.year.to_i)[:to]]
      get :balance_sheet,{:id => @current_user.tenant.id, :years => [Date.today.year]}
      expect(response).to render_template('balance_sheet')
      expect(assigns(:company)).to eq(@current_user.tenant.company)
      expect(assigns(:dates)).to eq(years)
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
