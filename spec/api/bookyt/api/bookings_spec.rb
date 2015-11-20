require 'spec_helper'

RSpec.describe Bookyt::API::Bookings, type: :request do
  let(:auth_token) { FactoryGirl.create(:user).authentication_token }
  let(:headers) do
    { 'Auth-Token' => auth_token }
  end

  describe 'GET /api/bookings' do
    let(:params) { {} }
    let!(:booking) { FactoryGirl.create(:account_booking) }

    it 'returns the bookings' do
      get '/api/bookings', params, headers
      expect(JSON.parse(response.body)).to be_instance_of(Array)
      expect(response.status).to eq(200)
    end

    it 'uses Bookyt::Entities::Booking to display the created Booking' do
      expect(Bookyt::Entities::Booking).to receive(:represent)
      get '/api/bookings', params, headers
    end
  end

  describe 'POST /api/bookings' do
    let(:params) do
      {
        title: 'Test',
        amount: 13.37,
        value_date: Date.today,
        credit_account_tag: 'incoming:test:credit',
        debit_account_tag: 'incoming:test:debit',
        comments: 'This is a loooooooooooong comment',
      }
    end

    context 'accounts present' do
      before do
        FactoryGirl.create(:account, tag_list: 'incoming:test:credit')
        FactoryGirl.create(:account, tag_list: 'incoming:test:debit')
      end

      it 'returns the created booking' do
        post '/api/bookings', params, headers
        expect(JSON.parse(response.body)).to be_instance_of(Hash)
        expect(response.status).to eq(201)
      end

      it 'creates a new booking' do
        expect { post '/api/bookings', params, headers }.to change(Booking, :count).from(0).to(1)
      end

      it 'uses Bookyt::Entities::Booking to display the created Booking' do
        expect(Bookyt::Entities::Booking).to receive(:represent)
        post '/api/bookings', params, headers
      end
    end

    context 'too many accounts found' do
      it 'returns an error' do
        expect(Account).to receive(:find_by_tag).and_raise(Account::AmbiguousTag.new('asd', 2))
        post '/api/bookings', params, headers
        expect(JSON.parse(response.body)).to be_instance_of(Hash)
        expect(response.status).to eq(422)
      end
    end

    context 'an account cannot be found' do
      it 'returns an error' do
        post '/api/bookings', params, headers
        expect(JSON.parse(response.body)).to be_instance_of(Hash)
        expect(response.status).to eq(422)
      end
    end
  end
end
