# Users Controller
#
# Provides a user/account management interface.
class UsersController < AuthorizedController
  # Actions
  def create
    @user = User.new(params[:user])
    @user.tenant = current_tenant

    create!
  end

  def update
    @user = User.find(params[:id])

    # Don't try to update password if not provided
    if params[:user][:password].blank?
      [:password, :password_confirmation].collect{|p| params[:user].delete(p) }
    end

    # Test if user is allowed to change roles
    unless params[:user][:role_texts].nil? || can?(:manage, Role)
      params[:user].delete(:role_texts)
    end

    # Set the locale explicitly to the user cause it wasn't saved.
    @user.locale = params[:user][:locale] if params[:user][:locale]

    # Special case if user can manage other users
    successfully_updated = if can? :manage, @user
      params[:user].delete(:current_password)
      @user.update_attributes(params[:user])
    else
      @user.update_with_password(params[:user])
    end

    if successfully_updated
      # Sign in the user bypassing validation in case his password changed
      sign_in @user, :bypass => true
      redirect_to user_path(@user)
    else
      render "edit"
    end
  end
end
