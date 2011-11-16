module ControllerMacros
  def login_admin
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      @current_user = Factory.create(:admin_user)
      sign_in @current_user
    end
  end

  def login_accountant
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      accountant = Factory.create(:accountant_user)
      @current_user = accountant
      sign_in accountant
    end
  end
end
