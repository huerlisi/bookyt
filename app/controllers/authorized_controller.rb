class AuthorizedController < InheritedResources::Base
  # Authorization
  load_and_authorize_resource

  rescue_from CanCan::AccessDenied do |exception|
    flash[:alert] = t('cancan.access_denied')

    if user_signed_in?
      if request.env["HTTP_REFERER"]
        # Show error on referring page for logged in users
        redirect_to :back
      else
        redirect_to root_path
      end
    else
      # Redirect to login page otherwise
      redirect_to new_user_session_path
    end
  end

  # Redirect to the called path before the login
  def after_sign_in_path_for(resource)
      (session[:"user.return_to"].nil?) ? "/" : session[:"user.return_to"].to_s
  end

  # Responders
  respond_to :html, :js, :json

  # Flash messages
  def interpolation_options
    { :resource_link => render_to_string(:partial => 'layouts/flash_new').html_safe }
  end

  # Set the user locale
  before_filter :set_locale
  def set_locale
    locale = params[:locale] || cookies[:locale]
    I18n.locale = locale.to_s
    cookies[:locale] = locale unless (cookies[:locale] && cookies[:locale] == locale)
  end

  # Resource setup
  protected
    def collection
      instance_eval("@#{controller_name.pluralize} ||= end_of_association_chain.accessible_by(current_ability, :list).paginate(:page => params[:page], :per_page => params[:per_page])")
    end
end
