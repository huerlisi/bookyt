# Users Controller
#
# Provides a user/account management interface.
class UsersController < AuthorizedController
  # Actions
  def update
    @user = User.find(params[:id])
    
    # Don't try to update password if not provided
    if params[:user][:password].blank?
      [:password, :password_confirmation, :current_password].collect{|p| params[:user].delete(p) }
    end

    # Test if user is allowed to change roles
    params[:user].delete(:role_texts) unless can? :manage, Role 
    update!
  end
end
