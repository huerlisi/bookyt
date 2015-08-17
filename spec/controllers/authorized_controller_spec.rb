require 'spec_helper'

describe AuthorizedController do
  before (:each) do
    @user = FactoryGirl.create(:user)
  end

  describe "after sign-in" do
    it "redirects to the root page" do
      expect(controller.after_sign_in_path_for(@user)).to eq('/')
    end

    it "redirects to the previous page" do
      redirect_path = '/test_redirect'
      controller.session[:"user.return_to"] = redirect_path
      expect(controller.after_sign_in_path_for(@user)).to eq(redirect_path)
    end
  end
end
