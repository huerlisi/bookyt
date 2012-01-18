class ApplicationController < ActionController::Base
  # Aspects
  protect_from_forgery

  # Authentication
  before_filter :authenticate_user!

  # Set the user locale
  before_filter :set_locale
  def set_locale
    I18n.locale = current_user.locale if current_user
  end

  # Tenancy
  def current_tenant
    current_user.tenant
  end
end
