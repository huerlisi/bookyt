require 'spec_helper'

RSpec.describe Account do
  describe '.find_by_tag' do
    let!(:account) { FactoryGirl.create(:account, tag_list: tag) }
    let(:tag) { 'asd:123' }

    context 'one account found with this tag' do
      specify { expect(Account.find_by_tag(tag)).to eq(account) }
    end

    context 'multiple accounts found with this tag' do
      before do
        FactoryGirl.create(:account, tag_list: tag)
      end

      it 'raises Account::AmbiguousTag' do
        expect { Account.find_by_tag(tag) }.to raise_error(Account::AmbiguousTag)
      end
    end
  end
end
