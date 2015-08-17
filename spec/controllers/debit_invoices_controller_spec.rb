require 'spec_helper'

describe DebitInvoicesController do
  context "as admin" do
    login_admin

    describe "POST copy" do
      it "duplicates an invoice" do
        invoice = FactoryGirl.create(:debit_invoice)
        get :copy, :id => invoice.id
        response.should render_template('edit')
        assigns(:debit_invoice).state.should eq('booked')
        assigns(:debit_invoice).value_date.should eq(Date.today)
        assigns(:debit_invoice).due_date.should eq(Date.today.in(30.days).to_date)
        assigns(:debit_invoice).duration_from.should be_nil
        assigns(:debit_invoice).duration_to.should be_nil
        assigns(:debit_invoice).title.should eq('DebitInvoice')
      end
    end
  end
end
