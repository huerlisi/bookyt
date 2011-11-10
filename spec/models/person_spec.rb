require 'spec_helper'

describe Person do
  its(:to_s) { should eq("") }

  context "when new" do
    @person = Person.new

    @person.to_s.should ==""
    @person.to_s(:long).should ==""
  end

  context "when existing" do
    @person = Factory.create(:person)

    @person.to_s.should =="Muster Peter"
    @person.to_s(:default).should =="Muster Peter"
    @person.to_s(:long).should =="Muster Peter (Capital)"
  end

  after(:all) do
    Person.delete_all
  end
end
