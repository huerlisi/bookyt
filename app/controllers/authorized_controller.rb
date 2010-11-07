class AuthorizedController < InheritedResources::Base
  # Authorization
  authorize_resource

  rescue_from CanCan::AccessDenied do |exception|
    flash[:alert] = t('cancan.access_denied')
    redirect_to :back
  end

  # Responders
  respond_to :html, :js

  # Resource setup
  protected
    def collection
      instance_eval("@#{controller_name.pluralize} ||= end_of_association_chain.accessible_by(current_ability, :list).paginate(:page => params[:page])")
    end
end
