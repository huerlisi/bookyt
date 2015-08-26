# coding: UTF-8

require 'spec_helper'

feature 'Reset the password' do

  given!(:user) { FactoryGirl.create :admin_user }

  background do
    user.send_reset_password_instructions
    visit "/admin_users/password/edit?reset_password_token=%s" % user.reset_password_token
  end

  scenario 'Set a new password' do
    expect(page).to have_content 'Passwort ändern'

    fill_in 'admin_user[password]', with: 'dont-forget-again'
    click_on 'Passwort ändern'
  end
end
