class LegacyBank < ActiveRecord::Base
  set_table_name 'banks'
end

class BankNowInheritsFromPerson < ActiveRecord::Migration
  def up
    add_column :people, :swift, :string
    add_column :people, :clearing, :string

    for bank in LegacyBank.all
      vcard = Vcard.where(:object_type => 'Bank', :object_id => bank.id).first
      person = Bank.create!(
        :vcard    => vcard,
        :swift    => bank.swift,
        :clearing => bank.clearing
      )

      if vcard
        vcard.object = person
        vcard.save!
      else
        person.build_vcard.save
      end
    end

    drop_table :banks
  end
end
