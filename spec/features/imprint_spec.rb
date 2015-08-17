# encoding: UTF-8

require 'spec_helper'

feature "Imprint Page" do
  scenario "When not logged in I should be able to view the imprint page" do
    visit "/"
    click_on 'Imprint'

    expect(page).to have_content('Impressum')
    expect(page).to have_content('Bookyt')
    expect(page).to have_content('AGPL')
    expect(page).to have_content('CyT')
  end
end
