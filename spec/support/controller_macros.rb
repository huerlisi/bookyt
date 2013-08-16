module ControllerMacros
  def login_admin
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      @current_user = FactoryGirl.create(:admin_user)
      sign_in @current_user
    end
  end

  def login_accountant
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      @current_user = FactoryGirl.create(:accountant_user)
      sign_in @current_user
    end
  end
end
