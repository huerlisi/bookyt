# encoding: UTF-8

class SetupController < ApplicationController
  def tenant
    # We only have one tenant
    @tenant = current_tenant
    @tenant.build_company
  end

  def accounting
    @tenant = current_tenant

    if @tenant.update_attributes(params[:tenant])
      render 'accounting'
    else
      render 'tenant'
    end
  end

  def select_template
  end

  def load_template
    locale = params[:template][:locale] if params[:template]

    # Guard
    redirect_to(setup_path) and return unless %w(de-CH nl-NL).include? locale

    load Rails.root.join('db', 'seeds', 'locales', "#{locale}.rb")

    redirect_to root_path, :notice => 'Template loaded.'
  end
end
