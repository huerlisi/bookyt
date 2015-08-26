require 'spec_helper'

describe CreditInvoicesController do
  context "as admin" do
    login_admin

    describe "POST copy" do
      it "duplicates an invoice" do
        invoice = FactoryGirl.create(:credit_invoice)
        get :copy, :id => invoice.id
        expect(response).to render_template('edit')
        expect(assigns(:credit_invoice).state).to eq('booked')
        expect(assigns(:credit_invoice).value_date).to eq(Date.today)
        expect(assigns(:credit_invoice).due_date).to eq(Date.today.in(30.days).to_date)
        expect(assigns(:credit_invoice).duration_from).to be_nil
        expect(assigns(:credit_invoice).duration_to).to be_nil
        expect(assigns(:credit_invoice).title).to eq('CreditInvoice')
      end
    end
  end
end
