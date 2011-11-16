require 'spec_helper'

shared_examples "user actions" do
  describe "the current user" do
    it "change name" do
      full_name = 'Mister X'
      put :update, {:id => @current_user.id, :user => {:full_name => full_name}}
      assigns(:user).should_not be_nil
      assigns(:user).should eq(@current_user)
      assigns(:user).should_not eq(User.new)
    end

    it "change the password" do
      new_password = '1234567890'
      current_password = @current_user.current_password
      put :update, {:id => @current_user.id, :user => {:password => new_password, :password_confirmation => new_password, :current_password => current_password}}
      assigns(:user).should_not be_nil
      assigns(:user).password.should eq(new_password)
      assigns(:user).password.should_not eq(current_password)
    end
  end

  describe "get user" do
    it "returns the current user" do
      get :current
      response.should redirect_to(@current_user)
    end
  end
end

describe UsersController do
  before(:each) do
    request.env["HTTP_REFERER"] = 'where_i_am_from'
  end

  context "as admin" do
    login_admin
    it_behaves_like "user actions"
    describe "update another user" do
      it "change the password" do
        user = Factory.create(:accountant_user)
        new_password = '1234567890'
        current_password = user.current_password
        put :update, {:id => user.id, :user => {:password => new_password, :password_confirmation => new_password, :current_password => current_password}}
        assigns(:user).should_not be_nil
        assigns(:user).password.should eq(new_password)
        assigns(:user).password.should_not eq(current_password)
      end
    end
  end

  context "as accountant" do
    login_accountant
    it_behaves_like "user actions"
    describe "can not update another user" do
      it "change the password" do
        user = Factory.create(:accountant_user)
        new_password = '1234567890'
        current_password = user.current_password
        put :update, {:id => user.id, :user => {:password => new_password, :password_confirmation => new_password, :current_password => current_password}}
        response.should redirect_to('where_i_am_from')
      end
    end
  end
end
