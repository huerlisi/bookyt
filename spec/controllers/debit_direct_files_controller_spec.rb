require 'spec_helper'

RSpec.describe DebitDirectFilesController, :type => :controller do
  login_admin

  describe 'POST create' do
    it 'uses DebitDirectFileCreator.call to create a DebitDirectFile' do
      expect(DebitDirectFileCreator).
        to receive(:call).with(instance_of(Tenant), instance_of(BankAccount)).and_return(true)
      post :create
    end
  end
end
