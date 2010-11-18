class TenantsController < AuthorizedController
  def current
    redirect_to current_user.tenant
  end
end
