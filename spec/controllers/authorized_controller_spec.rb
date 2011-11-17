require 'spec_helper'

describe AuthorizedController do
  controller do
    def after_sign_in_path_for(resource)
        super resource
    end
  end

  before (:each) do
    @user = FactoryGirl.create(:user)
  end

  describe "after sign-in" do
    it "redirects to the root page" do
        controller.after_sign_in_path_for(@user).should == root_path
    end
    
    pending "redirects to the previous page" do
      redirect_path = '/test_redirect'
      controller.session[:"user.return_to"] = redirect_path
      controller.after_sign_in_path_for(@user).should == redirect_path
    end
  end
end
