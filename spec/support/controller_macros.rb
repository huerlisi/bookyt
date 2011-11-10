module ControllerMacros
  def login_admin
    before do
      @admin = Factory.create(:admin_user)
      sign_in(@admin)
    end
    
    after do
      sign_out(@admin)
      @admin.delete
    end
  end

  def login_accountant
    before do
      @accountant = Factory.create(:accountant_user)
      Ability.stub(:user).and_return(@accountant)
      
      sign_in(@accountant)
    end
    
    after do
      sign_out(@accountant)
      @accountant.delete
    end
  end
end
