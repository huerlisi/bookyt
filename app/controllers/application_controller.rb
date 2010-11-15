class ApplicationController < ActionController::Base
  protect_from_forgery
  layout 'application'

  # Authentication
  before_filter :authenticate_user!

  # Tenancy
  def current_tenant
    current_user.tenant
  end
end
