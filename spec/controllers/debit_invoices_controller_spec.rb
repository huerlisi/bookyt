require 'spec_helper'

describe DebitInvoicesController do
  context "as admin" do
    login_admin

    describe "POST copy" do
      it "duplicates an invoice" do
        invoice = FactoryGirl.create(:debit_invoice)
        get :copy, :id => invoice.id
        expect(response).to render_template('edit')
        expect(assigns(:debit_invoice).state).to eq('booked')
        expect(assigns(:debit_invoice).value_date).to eq(Date.today)
        expect(assigns(:debit_invoice).due_date).to eq(Date.today.in(30.days).to_date)
        expect(assigns(:debit_invoice).duration_from).to be_nil
        expect(assigns(:debit_invoice).duration_to).to be_nil
        expect(assigns(:debit_invoice).title).to eq('DebitInvoice')
      end
    end
  end
end
