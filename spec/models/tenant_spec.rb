require 'spec_helper'

describe Tenant do
  it { should belong_to :company }

  context "on update" do
    subject { FactoryGirl.create :tenant }

    it { should validate_presence_of :company }
    pending { should validate_date :incorporated_on } # TODO: This validations can be checked at the moment
  end

  context "when new" do
    its(:to_s) { should == "" }
  end

  context "when properly initialized" do
    subject { FactoryGirl.build :tenant }

    its(:to_s) { should =~ /Muster Peter/ }
  end

  describe '#fiscal_years' do
    let(:tenant) { FactoryGirl.build :tenant }

    it 'should work with unset #fiscal_year_ends_on' do
      tenant.stub(:fiscal_year_ends_on => nil)

      expect{ tenant.fiscal_years }.to_not raise_exception
    end
  end
end
