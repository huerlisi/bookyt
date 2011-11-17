require 'spec_helper'

describe SettingsController do
  login_admin

  before(:each) do
    @bank_account = Factory.create(:bank_account)
  end

  describe "vesr setting" do
    it "returns the values" do
      get :vesr
      response.should be_success
      assigns(:tenant).should_not be_nil
      assigns(:tenant).should be_a_kind_of(Tenant)
      assigns(:tenant).should eq(@current_user.tenant)
      assigns(:bank_account).should_not be_nil
      assigns(:bank_account).should be_a_kind_of(BankAccount)
      assigns(:letter_template).should_not be_nil
      assigns(:letter_template).should be_a_kind_of(Attachment)
    end

    context "without attachment" do
      it "updates the values" do
        post :update_vesr, {:vesr => {:tenant => {:id => @current_user.tenant.id}, 
                                      :bank_account => {:id => @bank_account.id},
                                      :attachment => {}}}
        assigns(:tenant).should_not be_nil
        assigns(:tenant).should be_a_kind_of(Tenant)
        assigns(:tenant).should eq(@current_user.tenant)
        assigns(:bank_account).should_not be_nil
        assigns(:bank_account).should be_a_kind_of(BankAccount)
        assigns(:letter_template).should_not be_nil
        assigns(:letter_template).should be_a_kind_of(Attachment)
      end
    end

    context "with attachment" do
      it "updates the values" do
        attachment = Factory.create(:attachment)
        attachment_title = '2cb'
        post :update_vesr, {:vesr => {:tenant => {:id => @current_user.tenant.id}, 
                                      :bank_account => {:id => @bank_account.id},
                                      :attachment => {:id => attachment.id},
                                      :letter_template => {:title => attachment_title}}}
        assigns(:tenant).should_not be_nil
        assigns(:tenant).should be_a_kind_of(Tenant)
        assigns(:tenant).should eq(@current_user.tenant)
        assigns(:bank_account).should_not be_nil
        assigns(:bank_account).should be_a_kind_of(BankAccount)
        assigns(:letter_template).should_not be_nil
        assigns(:letter_template).should be_a_kind_of(Attachment)
        assigns(:letter_template).title.should eq(attachment_title)
      end
    end
  end
end
