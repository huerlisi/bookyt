require 'spec_helper'

describe UsersController do
  before(:each) do
    request.env["HTTP_REFERER"] = 'where_i_am_from'
  end

  describe "update" do
    context "as admin" do
      login_admin

      it "can update other users password without current password" do
        user = FactoryGirl.create(:user_accountant)
        new_password = '1234567890'
        put :update, {:id => user.id, :user => {:password => new_password, :password_confirmation => new_password}}

        user = assigns(:user)
        expect(user.errors[:current_password]).to be_empty

        user.reload
        user.valid_password?(new_password)
      end

      it "can update other users person without password" do
        user = FactoryGirl.create(:user_accountant)
        person = FactoryGirl.create(:person)
        put :update, {:id => user.id, :user => {:person_id => person.id}}

        user = assigns(:user)
        expect(user.errors).to be_empty

        user.reload
        expect(user.person).to eq(person)
      end

      it "cannot update other users if confirmation does not match" do
        user = FactoryGirl.create(:user_accountant)
        new_password = '1234567890'
        put :update, {:id => user.id, :user => {:password => new_password, :password_confirmation => 'wrong'}}

        user = assigns(:user)
        expect(user.errors[:password]).to be_present

        user.reload
        expect(user.valid_password?(new_password)).to eq(false)
      end

      it "should redirect to user view if successfull" do
        user = FactoryGirl.create(:user_accountant)
        new_password = '1234567890'
        put :update, {:id => user.id, :user => {:password => new_password, :password_confirmation => new_password}}

        user = assigns(:user)

        expect(response).to redirect_to(user_path(user))
      end

      it "should re-render edit if password and confirmation do not match" do
        user = FactoryGirl.create(:user_accountant)
        new_password = '1234567890'
        put :update, {:id => user.id, :user => {:password => new_password, :password_confirmation => 'wrong'}}

        user = assigns(:user)

        expect(response).to render_template('edit')
      end
    end

    context "as accountant" do
      login_accountant

      it "cannot update another user" do
        user = FactoryGirl.create(:user_accountant)
        new_password = '1234567890'
        current_password = user.current_password
        put :update, {:id => user.id, :user => {:password => new_password, :password_confirmation => new_password, :current_password => current_password}}
        expect(response).to redirect_to('where_i_am_from')
      end

      it "can update itself with correct current_password" do
        user = @current_user
        new_password = '1234567890'
        current_password = @current_user.password
        put :update, {:id => user.id, :user => {:password => new_password, :password_confirmation => new_password, :current_password => current_password}}

        user = assigns(:user)
        expect(user.errors[:current_password]).to be_empty

        user.reload
        expect(user.valid_password?(new_password)).to eq(true)
      end

      it "cannot update roles" do
        user = @current_user
        current_password = 'accountant1234'
        role_texts = ['admin']
        put :update, {:id => user.id, :user => {:role_texts => role_texts, :current_password => current_password}}

        user = assigns(:user)

        user.reload
        expect(user.role_texts).to match_array(['accountant'])
      end

      it "cannot update itself without current_password" do
        user = @current_user
        new_password = '1234567890'
        put :update, {:id => user.id, :user => {:password => new_password, :password_confirmation => new_password}}

        user = assigns(:user)
        expect(user.errors[:current_password]).to be_present

        user.reload
        expect(user.valid_password?(new_password)).to eq(false)
      end

      it "cannot update itself with wrong current_password" do
        user = @current_user
        new_password = '1234567890'
        put :update, {:id => user.id, :user => {:password => new_password, :password_confirmation => new_password, :current_password => 'wrong'}}

        user = assigns(:user)
        expect(user.errors[:current_password]).to be_present

        user.reload
        expect(user.valid_password?(new_password)).to eq(false)
      end
    end
  end
end
