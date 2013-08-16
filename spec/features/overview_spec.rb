# encoding: UTF-8

require 'spec_helper'

feature "Welcome Screen" do
  scenario "When not logged in I should see the login form" do
    visit "/"

    page.should have_content('Anmelden')
  end

  scenario "When logged in as admin I should see the page title" do
    log_in
    visit '/'
    expect(page).to have_text("Bookyt")
  end
end
