class ApplicationController < ActionController::Base
  # Aspects
  protect_from_forgery

  # Authentication
  before_filter :authenticate_user!

  # Set the user locale
  before_filter :set_locale
  def set_locale
    locale = params[:locale] || cookies[:locale]
    I18n.locale = locale.to_s
    cookies[:locale] = locale unless (cookies[:locale] && cookies[:locale] == locale)
  end

  # Tenancy
  def current_tenant
    current_user.tenant
  end
end
