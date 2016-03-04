require 'spec_helper'

RSpec.describe Bookyt::API::Customers, type: :request do
  let(:auth_token) { FactoryGirl.create(:user).authentication_token }
  let(:headers) do
    { 'Auth-Token' => auth_token }
  end

  describe 'GET /api/customers' do
    let(:params) { {} }
    let!(:customer) { FactoryGirl.create(:customer) }

    it 'returns the customers' do
      get '/api/customers', params, headers
      expect(JSON.parse(response.body)).to be_instance_of(Array)
      expect(response.status).to eq(200)
    end

    it 'uses Bookyt::Entities::Person to display the Customer' do
      expect(Bookyt::Entities::Person).to receive(:represent)
      get '/api/customers', params, headers
    end
  end

  describe 'POST /api/customers' do
    let(:params) do
      {
        name: 'Bruce Wayne',
        street: 'Waynestreet 12',
        zip: 1234,
        city: 'Waynecity',
        phone_numbers: [
          type: 'mobile',
          number: '123-dont-call-me',
        ]
      }
    end

    it 'returns the created customer' do
      post '/api/customers', params, headers
      expect(JSON.parse(response.body)).to be_instance_of(Hash)
      expect(response.status).to eq(201)
    end

    it 'creates a new customer' do
      expect { post '/api/customers', params, headers }.to change(Customer, :count).from(0).to(1)
    end

    it 'uses Bookyt::Entities::Person to display the created Customer' do
      expect(Bookyt::Entities::Person).to receive(:represent)
      post '/api/customers', params, headers
    end

    it 'allows setting the lsv attributes' do
      params.merge!(:direct_debit_enabled => true, :bank_clearing_number => '12', :bank_account_number => 'a')
      post '/api/customers', params, headers
      expect(Customer.last.direct_debit_enabled).to eq(true)
      expect(Customer.last.clearing).to eq('12')
      expect(Customer.last.bank_account).to eq('a')
    end
  end

  describe 'GET /api/customers/:id' do
    let(:params) { {} }
    let!(:customer) { FactoryGirl.create(:customer) }

    context 'accounts present' do
      it 'returns the customer' do
        get "/api/customers/#{customer.id}", params, headers
        expect(JSON.parse(response.body)).to be_instance_of(Hash)
        expect(response.status).to eq(200)
      end

      it 'uses Bookyt::Entities::Person to display the Customer' do
        expect(Bookyt::Entities::Person).to receive(:represent)
        get "/api/customers/#{customer.id}", params, headers
      end
    end
  end

  describe 'PUT /api/customers/:id' do
    let(:params) do
      {
        name: 'Bruce Wayne',
        street: 'Waynestreet 12',
        zip: 1234,
        city: 'Waynecity',
        phone_numbers: [
          type: 'mobile',
          number: '123-dont-call-me',
        ]
      }
    end
    let!(:customer) { FactoryGirl.create(:customer) }

    it 'returns the updated customer' do
      put "/api/customers/#{customer.id}", params, headers
      expect(JSON.parse(response.body)).to be_instance_of(Hash)
      expect(response.status).to eq(200)
    end

    it 'updates the customer' do
      expect { put "/api/customers/#{customer.id}", params, headers }.
        to change { customer.vcard.reload.full_name }
    end

    it 'uses Bookyt::Entities::Person to display the updated Customer' do
      expect(Bookyt::Entities::Person).to receive(:represent)
      put "/api/customers/#{customer.id}", params, headers
    end

    it 'does not create a new VCard' do
      expect { put "/api/customers/#{customer.id}", params, headers }.
        to_not change { customer.reload.vcard.id }
    end

    it 'does create a new PhoneNumber' do
      expect { put "/api/customers/#{customer.id}", params, headers }.
        to change { HasVcards::PhoneNumber.count }.from(0).to(1)
    end

    it 'allows setting the lsv attributes' do
      params.merge!(:direct_debit_enabled => true, :bank_clearing_number => '12', :bank_account_number => 'a')
      put "/api/customers/#{customer.id}", params, headers
      customer.reload
      expect(customer.direct_debit_enabled).to eq(true)
      expect(customer.clearing).to eq('12')
      expect(customer.bank_account).to eq('a')
    end
  end

  describe 'DELETE /api/customers/:id' do
    let(:params) { {} }
    let!(:customer) { FactoryGirl.create(:customer) }

    it 'removes the customer' do
      delete "/api/customers/#{customer.id}", params, headers
      expect(response.body).to eq('')
      expect(response.status).to eq(204)
    end

    it 'creates a new customer' do
      expect { delete "/api/customers/#{customer.id}", params, headers }.
        to change(Customer, :count).from(1).to(0)
    end
  end
end
