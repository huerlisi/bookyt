require 'spec_helper'

describe Ability do
  describe '.roles' do
    it 'supports "admin" and "accountant"' do
      expect(Ability.roles).to match_array ['admin', 'accountant']
    end

    it 'maps roles to translations' do
      expect(Ability.roles_for_collection).to match_array [['Administrator', 'admin'], ['Buchhalter', 'accountant']]
    end
  end
end
