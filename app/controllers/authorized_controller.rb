class AuthorizedController < InheritedResources::Base
  # Authorization
  authorize_resource

  rescue_from CanCan::AccessDenied do |exception|
    flash[:alert] = t('cancan.access_denied')
    redirect_to :back
  end

  # Responders
  respond_to :html, :js

  # Set the user locale
  before_filter :set_locale
  def set_locale
    I18n.locale = current_user.locale if current_user
  end

  # Resource setup
  protected
    def collection
      instance_eval("@#{controller_name.pluralize} ||= end_of_association_chain.accessible_by(current_ability, :list).paginate(:page => params[:page], :per_page => params[:per_page])")
    end
end
