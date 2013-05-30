class Admin::TenantsController < ApplicationController
  layout 'admin'
  skip_before_filter :authenticate_user!
  before_filter :authenticate_admin_user!
  inherit_resources

  # Define a specific ability helper using the admin user
  def current_ability
    @current_ability ||= Ability.new(current_admin_user)
  end

  # Actions
  # =======
  def new
    @tenant = Tenant.new(params[:tenant])
    @user = @tenant.users.build(params[:user])
  end

  def create
    @tenant = Tenant.new(params[:tenant])
    if @tenant.valid?
      Apartment::Database.create(@tenant.code)
      Apartment::Database.switch(@tenant.code)
      load "db/seeds.rb"

      @user = @tenant.users.build(params[:user])
      @user.role_texts = ['admin']

      if @user.valid?
        @tenant.save!
        redirect_to [:admin, @tenant]
      else
        render 'new'
      end
    else
      render 'new'
    end
  end
end
