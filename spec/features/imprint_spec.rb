# encoding: UTF-8

require 'spec_helper'

feature "Imprint Page" do
  scenario "When not logged in I should be able to view the imprint page" do
    visit "/"
    click_on 'Imprint'

    page.should have_content('Impressum')
    page.should have_content('Bookyt')
    page.should have_content('AGPL')
    page.should have_content('CyT')
  end
end
