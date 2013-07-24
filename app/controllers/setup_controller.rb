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
end
