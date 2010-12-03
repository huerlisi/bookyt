class ApplicationController < ActionController::Base
  # Aspects
  protect_from_forgery

  # Authentication
  before_filter :authenticate_user!

  # Tenancy
  def current_tenant
    current_user.tenant
  end
end
