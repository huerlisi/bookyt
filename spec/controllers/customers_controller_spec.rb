require 'spec_helper'

shared_examples "customer actions" do
  describe "show" do
    it "the customer" do
      get :show, :id => @customer.id
      response.should render_template('show')
      assigns(:customer).should_not be_nil
      assigns(:customer).should be_an_instance_of(Customer)
    end

    it "the open debit invoices" do
      get :show, :id => @customer.id
      response.should render_template('show')
      assigns(:open_debit_invoices).should_not be_empty
      assigns(:open_debit_invoices).count.should be(3)
      assigns(:open_debit_invoices).first.should be_an_instance_of(DebitInvoice)
    end

    it "the paid debit invoices" do
      get :show, :id => @customer.id
      response.should render_template('show')
      assigns(:paid_debit_invoices).should_not be_empty
      assigns(:paid_debit_invoices).count.should be(3)
      assigns(:paid_debit_invoices).first.should be_an_instance_of(DebitInvoice)
    end
  end
end

describe CustomersController do
  before(:all) do
    @customer = Factory.create(:customer)
    (0..2).each do
      Factory.create(:open_debit_invoice, :customer => @customer)
      Factory.create(:paid_debit_invoice, :customer => @customer)
    end
  end

  context "as admin" do
    login_admin
    it_behaves_like "customer actions"
  end

  context "as accountant" do
    login_accountant
    it_behaves_like "customer actions"
  end
end
