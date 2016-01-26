require 'spec_helper'

RSpec.describe Bookyt::API::DebitDirectFiles, type: :request do
  let(:user) { FactoryGirl.create(:user) }
  let(:auth_token) { user.authentication_token }
  let(:headers) do
    { 'Auth-Token' => auth_token }
  end

  describe 'GET /api/debit_direct_files' do
    let(:params) { {} }
    let!(:debit_direct_file) { FactoryGirl.create(:debit_direct_file) }

    it 'returns the debit_direct_files' do
      get '/api/debit_direct_files', params, headers
      expect(JSON.parse(response.body)).to be_instance_of(Array)
      expect(response.status).to eq(200)
    end

    it 'uses Bookyt::Entities::DebitDirectFile to display the DebitDirectFile' do
      expect(Bookyt::Entities::DebitDirectFile).to receive(:represent)
      get '/api/debit_direct_files', params, headers
    end
  end

  describe 'POST /api/debit_direct_files' do
    let(:customer) { FactoryGirl.create :customer }
    let(:params) { {} }
    let(:debit_direct_file) { FactoryGirl.create :debit_direct_file }
    let!(:bank_account) { FactoryGirl.create :bank_account, tag_list: 'invoice:vesr' }

    before do
      allow(DebitDirectFileCreator).to receive(:call).and_return(debit_direct_file)
    end

    it 'returns the created debit_direct_file' do
      post '/api/debit_direct_files', params, headers
      expect(JSON.parse(response.body)).to be_instance_of(Hash)
      expect(response.status).to eq(201)
    end

    it 'calls DebitDirectFileCreator' do
      allow(DebitDirectFileCreator).
        to receive(:call).with(instance_of(Tenant), bank_account).and_return(debit_direct_file)
      post '/api/debit_direct_files', params, headers
    end

    it 'uses Bookyt::Entities::DebitDirectFile to display the created DebitDirectFile' do
      expect(Bookyt::Entities::DebitDirectFile).to receive(:represent)
      post '/api/debit_direct_files', params, headers
    end
  end

  describe 'GET /api/debit_direct_files/:id' do
    let(:params) { {} }
    let!(:debit_direct_file) { FactoryGirl.create(:debit_direct_file) }

    context 'accounts present' do
      it 'returns the debit_direct_file' do
        get "/api/debit_direct_files/#{debit_direct_file.id}", params, headers
        expect(JSON.parse(response.body)).to be_instance_of(Hash)
        expect(response.status).to eq(200)
      end

      it 'uses Bookyt::Entities::DebitDirectFile to display the DebitDirectFile' do
        expect(Bookyt::Entities::DebitDirectFile).to receive(:represent)
        get "/api/debit_direct_files/#{debit_direct_file.id}", params, headers
      end
    end
  end
end
