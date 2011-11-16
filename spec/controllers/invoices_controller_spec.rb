require 'spec_helper'

shared_examples "invoice actions" do
  describe "should create an invoice" do
    it "duplicates an invoice" do
      invoice = Factory.create(:invoice)
      get :copy, :id => invoice.id
      response.should render_template('edit')
      assigns(:invoice).state.should eq('booked')
      assigns(:invoice).value_date.should eq(Date.today)
      assigns(:invoice).due_date.should eq(Date.today.in(30.days).to_date)
      assigns(:invoice).duration_from.should be_nil
      assigns(:invoice).duration_to.should be_nil
      assigns(:invoice).title.should eq('New Invoice')
    end
  end
end

describe InvoicesController do
  context "as admin" do
    login_admin
    it_behaves_like "invoice actions"
  end

  context "as accountant" do
    login_accountant
    it_behaves_like "invoice actions"
  end
end
