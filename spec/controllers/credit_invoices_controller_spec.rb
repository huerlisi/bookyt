require 'spec_helper'

describe CreditInvoicesController do
  context "as admin" do
    login_admin

    describe "POST copy" do
      it "duplicates an invoice" do
        invoice = FactoryGirl.create(:credit_invoice)
        get :copy, :id => invoice.id
        response.should render_template('edit')
        assigns(:credit_invoice).state.should eq('booked')
        assigns(:credit_invoice).value_date.should eq(Date.today)
        assigns(:credit_invoice).due_date.should eq(Date.today.in(30.days).to_date)
        assigns(:credit_invoice).duration_from.should be_nil
        assigns(:credit_invoice).duration_to.should be_nil
        assigns(:credit_invoice).title.should eq('CreditInvoice')
      end
    end
  end
end
