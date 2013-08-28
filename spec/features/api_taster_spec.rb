require 'spec_helper'

feature "API Taster" do
  context "when not logged in as user" do
    scenario "Should redirect to login" do
      visit '/api_taster'
      current_path.should == user_session_path
    end
  end

  context "when logged in as user" do
    let!(:user) { FactoryGirl.create(:user) }

    before do
      visit new_user_session_path
      fill_in "user_email", :with => user.email
      fill_in "user_password", :with => user.password
      click_button "Anmelden"
    end

    scenario "Should show /api_taster" do
      visit '/api_taster'
      current_path.should == '/api_taster'
      page.should have_text 'API Taster'
    end
  end
end
