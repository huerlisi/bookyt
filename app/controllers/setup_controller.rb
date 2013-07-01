# encoding: UTF-8

class SetupController < ApplicationController
  def tenant
    # We only have one tenant
    @tenant = Tenant.first
  end
end
