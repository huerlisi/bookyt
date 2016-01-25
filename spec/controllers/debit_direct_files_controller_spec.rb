require 'spec_helper'

RSpec.describe DebitDirectFilesController, :type => :controller do
  login_admin

  describe 'POST create' do
    let!(:bank_account) { FactoryGirl.create(:bank_account, tag_list: 'invoice:vesr') }
    let(:debit_direct_file) { FactoryGirl.create(:debit_direct_file) }

    it 'uses DebitDirectFileCreator.call to create a DebitDirectFile' do
      expect(DebitDirectFileCreator).
        to receive(:call).with(instance_of(Tenant), bank_account).and_return(debit_direct_file)
      post :create
    end
  end
end
