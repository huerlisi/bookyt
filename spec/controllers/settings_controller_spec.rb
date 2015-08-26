require 'spec_helper'

describe SettingsController do
  login_admin

  before(:each) do
    @bank_account = FactoryGirl.create(:bank_account, tag_list: %w(invoice:vesr))
  end

  describe "vesr setting" do
    it "returns the values" do
      get :vesr
      expect(response).to be_success
      expect(assigns(:tenant)).not_to be_nil
      expect(assigns(:tenant)).to be_a_kind_of(Tenant)
      expect(assigns(:tenant)).to eq(@current_user.tenant)
      expect(assigns(:bank_account)).not_to be_nil
      expect(assigns(:bank_account)).to be_a_kind_of(BankAccount)
      expect(assigns(:letter_template)).not_to be_nil
      expect(assigns(:letter_template)).to be_a_kind_of(Attachment)
    end

    context "without attachment" do
      it "updates the values" do
        post :update_vesr, {:vesr => {:tenant => {:id => @current_user.tenant.id},
                                      :bank_account => {:id => @bank_account.id},
                                      :attachment => {}}}
        expect(assigns(:tenant)).not_to be_nil
        expect(assigns(:tenant)).to be_a_kind_of(Tenant)
        expect(assigns(:tenant)).to eq(@current_user.tenant)
        expect(assigns(:bank_account)).not_to be_nil
        expect(assigns(:bank_account)).to be_a_kind_of(BankAccount)
        expect(assigns(:letter_template)).not_to be_nil
        expect(assigns(:letter_template)).to be_a_kind_of(Attachment)
      end
    end

    context "with attachment" do
      it "updates the values" do
        attachment = FactoryGirl.create(:attachment)
        attachment_title = '2cb'
        post :update_vesr, {:vesr => {:tenant => {:id => @current_user.tenant.id},
                                      :bank_account => {:id => @bank_account.id},
                                      :attachment => {:id => attachment.id},
                                      :letter_template => {:title => attachment_title}}}
        expect(assigns(:tenant)).not_to be_nil
        expect(assigns(:tenant)).to be_a_kind_of(Tenant)
        expect(assigns(:tenant)).to eq(@current_user.tenant)
        expect(assigns(:bank_account)).not_to be_nil
        expect(assigns(:bank_account)).to be_a_kind_of(BankAccount)
        expect(assigns(:letter_template)).not_to be_nil
        expect(assigns(:letter_template)).to be_a_kind_of(Attachment)
        expect(assigns(:letter_template).title).to eq(attachment_title)
      end
    end
  end
end
