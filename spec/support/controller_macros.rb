module ControllerMacros
  def login_admin
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in Factory.create(:admin_user)
    end
  end

  def login_accountant
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      accountant = Factory.create(:accountant_user)
      sign_in accountant
    end
  end
end
