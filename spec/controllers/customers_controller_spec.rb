require 'spec_helper'

shared_examples "customer actions" do
  describe "show" do
    it "the customer" do
      get :show, :id => 20000
      expect(response).to render_template('show')
      expect(assigns(:customer)).not_to be_nil
      expect(assigns(:customer)).to be_an_instance_of(Customer)
    end
  end
end

describe CustomersController do
  before(:all) do
    FactoryGirl.create(:customer, :id => 20000)
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
