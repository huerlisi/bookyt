require 'spec_helper'

shared_examples "people actions" do
  describe "show" do
    it "the person" do
      get :show, :id => 200000
      response.should render_template('show')
      assigns(:person).should_not be_nil
      assigns(:person).should be_an_instance_of(Person)
    end

    it "the debit invoices" do
      get :show, :id => 200000
      response.should render_template('show')
      assigns(:debit_invoices).should be_empty
    end

    it "the credit invoices" do
      get :show, :id => 200000
      response.should render_template('show')
      assigns(:credit_invoices).should be_empty
    end
  end
end

describe PeopleController do
  before(:all) do
    Factory.create(:person, :id => 200000)
  end

  context "as admin" do
    login_admin
    it_behaves_like "people actions"
  end

  context "as accountant" do
    login_accountant
    it_behaves_like "people actions"
  end  
end