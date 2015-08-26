# encoding: UTF-8

require 'spec_helper'

feature "Tenant settings" do
  scenario "Tenant settings can be changed", js: true do
    log_in
    visit '/'

    # Navigate to tenant settings
    click_on 'Einstellungen'
    click_on 'Mandant'

    # Fill in address
    within '.content' do
      expect(page).to have_content('Adresse')

      fill_in 'Name', with: 'Simon Hürlimann'
      fill_in 'Adresszusatz', with: ''
      fill_in 'Strasse', with: 'Dorfstrasse 12'
      fill_in 'PLZ', with: '6300'
      fill_in 'Ort', with: 'Zug'

      click_on 'Mandant aktualisieren'
    end

    # Check if address is persisted
    visit current_path

    expect(page).to have_field 'Name', with: 'Simon Hürlimann'
    expect(page).to have_field 'Adresszusatz', with: ''
    expect(page).to have_field 'Strasse', with: 'Dorfstrasse 12'
    expect(page).to have_field 'PLZ', with: '6300'
    expect(page).to have_field 'Ort', with: 'Zug'

    # Fill in accounting settings
    within '.content' do
      click_on 'Buchhaltung'

      expect(page).to have_content('Buchhaltung')

      fill_in 'Gründung', with: '21.06.2006'
      fill_in 'Ende des 1. Fiskaljahres', with: '31.12.2006'
      fill_in 'MwSt.-Nummer', with: 'CHE-123.345.678 MWST'
      fill_in 'UID-Nummer', with: 'CHE-123.345.678'
      fill_in 'AHV Abrechnungsnr.', with: '123.456'

      expect(page).to have_content('Rechnungseinstellungen')

      fill_in 'Zahlungsfrist in Tagen', with: '30'

      click_on 'Mandant aktualisieren'
    end

    # Check if invoice settings are persisted
    visit current_path

    within '.content' do
      click_on 'Buchhaltung'

      expect(page).to have_field 'Gründung', with: '21.06.2006'
      expect(page).to have_field 'Ende des 1. Fiskaljahres', with: '31.12.2006'
      expect(page).to have_field 'MwSt.-Nummer', with: 'CHE-123.345.678 MWST'
      expect(page).to have_field 'UID-Nummer', with: 'CHE-123.345.678'
      expect(page).to have_field 'AHV Abrechnungsnr.', with: '123.456'

      expect(page).to have_field 'Zahlungsfrist in Tagen', with: '30'
    end

    # Fill in VESR settings
    within '.content' do
      click_on 'VESR'

      expect(page).to have_content('VESR Einstellungen')

      check 'VESR für Debitoren-Rechnungen'
      check '"Zugunsten von" auf Einzahlungschein drucken'

      click_on 'Mandant aktualisieren'
    end

    # Check if VESR settings are persisted
    visit current_path

    within '.content' do
      click_on 'VESR'

      expect(page.find_field('VESR für Debitoren-Rechnungen')).to be_checked
      expect(page.find_field('"Zugunsten von" auf Einzahlungschein drucken')).to be_checked
    end

    # Check if attachment section exists
    expect(page).to have_link('Dokumente')

    # Check if backup section exists
    expect(page).to have_link('Backups')
  end
end
