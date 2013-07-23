require 'spec_helper'

describe Ability do
  context "as singleton" do
    roles = Ability.roles
    roles_collection = Ability.roles_for_collection
    roles.should == ['admin', 'accountant']
    roles_collection.should == [['Administrator', 'admin'], ['Buchhalter', 'accountant']]
  end
end
