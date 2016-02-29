require 'spec_helper'

describe Tenant do
  it { is_expected.to belong_to :company }

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
      allow(tenant).to receive_messages(:fiscal_year_ends_on => nil)

      expect{ tenant.fiscal_years }.to_not raise_exception
    end

    context 'leap year' do
      let(:tenant) { FactoryGirl.build :tenant, fiscal_year_ends_on: Date.new(2016, 2, 29) }

      it 'does not raise an error' do
        expect { tenant.fiscal_years }.to_not raise_exception
      end
    end
  end
end
