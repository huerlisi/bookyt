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
    @tenant = Admin::Tenant.new(params[:admin_tenant])
    @user = User.new(params[:user])
  end

  def create
    @tenant = Admin::Tenant.new(params[:admin_tenant])
    @tenant.db_name ||= @tenant.subdomain
    @user = User.new(params[:user])
    @user.role_texts = ['admin']

    if @tenant.valid?
      @tenant.save
      Apartment::Database.create(@tenant.db_name)
      Apartment::Database.switch(@tenant.db_name)
      load "db/seeds.rb"

      @user.save
      redirect_to @tenant
    else
      raise @tenant.errors.inspect + @user.errors.inspect

      render 'new'
    end
  end
end
