require 'spec_helper'

shared_examples "booking template" do
  describe "list all" do
    it "booking templates" do
      get :index
      assigns(:booking_templates).should_not be_nil
      assigns(:booking_templates).should_not be_empty
      assigns(:booking_templates).first.should be_a_kind_of(BookingTemplate)
    end
  end

  describe "create" do
    it "a booking template successfully" do
      title = 'Kreditkarten Einnahmen'
      code = 'day:card turnover'
      matcher = 'test'
      credit_account = FactoryGirl.create(:eft_account)
      debit_account = FactoryGirl.create(:service_account)
      post :create, {:booking_template => {:title => title,
                                           :code => code,
                                           :matcher => matcher,
                                           :credit_account_id => credit_account.id,
                                           :debit_account_id => debit_account.id}}
      response.should redirect_to('/booking_templates')
      assigns(:booking_template).title.should eq(title)
    end
  end

  describe "update" do
    it "a booking template successfully" do
      booking_template = FactoryGirl.create(:invoice_booking_template)
      new_title = 'title'
      put :update, {:id => booking_template.id, :booking_template => {:title => new_title}}
      response.should redirect_to('/booking_templates')
      assigns(:booking_template).title.should eq(new_title)
    end
  end
end

describe BookingTemplatesController do
  before(:all) do
    FactoryGirl.create(:booking_template)
  end

  context "as admin" do
    login_admin
    it_behaves_like "booking template"
  end

  context "as accountant" do
    login_accountant
    it_behaves_like "booking template"
  end
end