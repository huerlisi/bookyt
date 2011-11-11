require 'spec_helper'

describe CreditInvoicesController do
  context "as admin" do
    login_admin

    describe "GET new" do
      it " " do
        get :new
        response.should render_template("new")
        assigns(:credit_invoice)
      end
    end

    pending "can create" do
      it "should create a credit invoice" do
        post '/credit_invoices'
      end
    end
  end
end
