require 'spec_helper'

shared_examples "invoice actions" do
  describe "should create an invoice" do
    it "duplicates an invoice" do
      invoice = FactoryGirl.create(:invoice)
      get :copy, :id => invoice.id
      expect(response).to render_template('edit')
      expect(assigns(:invoice).state).to eq('booked')
      expect(assigns(:invoice).value_date).to eq(Date.today)
      expect(assigns(:invoice).due_date).to eq(Date.today.in(30.days).to_date)
      expect(assigns(:invoice).duration_from).to be_nil
      expect(assigns(:invoice).duration_to).to be_nil
      expect(assigns(:invoice).title).to eq('New Invoice')
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
