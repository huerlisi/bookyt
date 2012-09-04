require 'spec_helper'

shared_examples "user actions" do
  describe "the current user" do
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

  describe "update" do
    context "as admin" do
      login_admin

      it "can update other users without current password" do
        user = Factory.create(:accountant_user)
        new_password = '1234567890'
        put :update, {:id => user.id, :user => {:password => new_password, :password_confirmation => new_password}}

        user = assigns(:user)
        user.errors[:current_password].should be_empty

        user.reload
        user.valid_password?(new_password)
      end

      it "cannot update other users if confirmation does not match" do
        user = Factory.create(:accountant_user)
        new_password = '1234567890'
        put :update, {:id => user.id, :user => {:password => new_password, :password_confirmation => 'wrong'}}

        user = assigns(:user)
        user.errors[:password].should be_present

        user.reload
        user.valid_password?(new_password).should be_false
      end

      it "should redirect to user view if successfull" do
        user = Factory.create(:accountant_user)
        new_password = '1234567890'
        put :update, {:id => user.id, :user => {:password => new_password, :password_confirmation => new_password}}

        user = assigns(:user)

        response.should redirect_to(user_path(user))
      end

      it "should re-render edit if password and confirmation do not match" do
        user = Factory.create(:accountant_user)
        new_password = '1234567890'
        put :update, {:id => user.id, :user => {:password => new_password, :password_confirmation => 'wrong'}}

        user = assigns(:user)

        response.should render_template('edit')
      end
    end

    context "as accountant" do
      login_accountant

      it "can not update another user" do
        user = Factory.create(:accountant_user)
        new_password = '1234567890'
        current_password = user.current_password
        put :update, {:id => user.id, :user => {:password => new_password, :password_confirmation => new_password, :current_password => current_password}}
        response.should redirect_to('where_i_am_from')
      end

      it "can update itself with correct current_password" do
        user = @current_user
        new_password = '1234567890'
        current_password = 'accountant1234'
        put :update, {:id => user.id, :user => {:password => new_password, :password_confirmation => new_password, :current_password => current_password}}

        user = assigns(:user)
        user.errors[:current_password].should be_empty

        user.reload
        user.valid_password?(new_password).should be_true
      end

      it "cannot update itself without current_password" do
        user = @current_user
        new_password = '1234567890'
        put :update, {:id => user.id, :user => {:password => new_password, :password_confirmation => new_password}}

        user = assigns(:user)
        user.errors[:current_password].should be_present

        user.reload
        user.valid_password?(new_password).should be_false
      end

      it "cannot update itself with wrong current_password" do
        user = @current_user
        new_password = '1234567890'
        put :update, {:id => user.id, :user => {:password => new_password, :password_confirmation => new_password, :current_password => 'wrong'}}

        user = assigns(:user)
        user.errors[:current_password].should be_present

        user.reload
        user.valid_password?(new_password).should be_false
      end
    end
  end
end
