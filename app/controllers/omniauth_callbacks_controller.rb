class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
    @user = User.find_by_email(auth_hash['info']['email'])

    if @user
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Google"
      sign_in_and_redirect @user, :event => :authentication
    else
      flash[:alert] = I18n.t "devise.omniauth_callbacks.failure", :kind => "Google", :reason => I18n.t("devise.omniauth_callbacks.failure_reason")
      redirect_to new_user_session_url
    end
  end

  def auth_hash
    request.env["omniauth.auth"]
  end
end
