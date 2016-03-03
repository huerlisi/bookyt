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

    it 'uses Bookyt::Entities::Booking to display the Booking' do
      expect(Bookyt::Entities::Booking).to receive(:represent)
      get '/api/bookings', params, headers
    end
  end

  describe 'POST /api/bookings' do
    let(:invoice) { FactoryGirl.create(:debit_invoice) }
    let(:params) do
      {
        title: 'Test',
        amount: 13.37,
        value_date: Date.today,
        credit_account_code: '1100',
        debit_account_code: '3200',
        comments: 'This is a loooooooooooong comment',
        invoice_id: invoice.id,
      }
    end

    context 'accounts present' do
      before do
        FactoryGirl.create(:account, code: '1100')
        FactoryGirl.create(:account, code: '3200')
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

      it 'assigns the booking to the given invoice' do
        expect { post '/api/bookings', params, headers }.to change { invoice.bookings.count }.from(0).to(1)
      end

      context 'invoice id does not exist' do
        it 'validates presence of the invoice id' do
          params[:invoice_id] = 'asd'
          post '/api/bookings', params, headers
          expect(JSON.parse(response.body)).to be_instance_of(Hash)
          expect(response.status).to eq(400)
        end
      end

      context 'invoice id is nil' do
        it 'does not care about a nil value' do
          params[:invoice_id] = nil
          post '/api/bookings', params, headers
          expect(response.status).to eq(201)
        end
      end
    end
  end

  describe 'GET /api/bookings/:id' do
    let(:params) { {} }
    let!(:booking) { FactoryGirl.create(:account_booking) }

    context 'accounts present' do
      it 'returns the booking' do
        get "/api/bookings/#{booking.id}", params, headers
        expect(JSON.parse(response.body)).to be_instance_of(Hash)
        expect(response.status).to eq(200)
      end

      it 'uses Bookyt::Entities::Booking to display the Booking' do
        expect(Bookyt::Entities::Booking).to receive(:represent)
        get "/api/bookings/#{booking.id}", params, headers
      end
    end
  end

  describe 'PUT /api/bookings/:id' do
    let(:invoice) { FactoryGirl.create(:debit_invoice) }
    let(:params) do
      {
        title: 'Test',
        amount: 13.37,
        value_date: Date.today,
        credit_account_code: '1100',
        debit_account_code: '3200',
        comments: 'This is a loooooooooooong comment',
        invoice_id: invoice.id,
      }
    end
    let!(:booking) { FactoryGirl.create :account_booking }

    context 'accounts present' do
      before do
        FactoryGirl.create(:account, code: '1100')
        FactoryGirl.create(:account, code: '3200')
      end

      it 'returns the booking' do
        put "/api/bookings/#{booking.id}", params, headers
        expect(JSON.parse(response.body)).to be_instance_of(Hash)
        expect(response.status).to eq(200)
      end

      it 'creates a new booking' do
        expect { put "/api/bookings/#{booking.id}", params, headers }.to change { booking.reload.amount }
      end

      it 'uses Bookyt::Entities::Booking to display the Booking' do
        expect(Bookyt::Entities::Booking).to receive(:represent)
        put "/api/bookings/#{booking.id}", params, headers
      end

      it 'assigns the booking to the given invoice' do
        expect { post '/api/bookings', params, headers }.to change { invoice.bookings.count }.from(0).to(1)
      end

      context 'invoice id does not exist' do
        it 'validates presence of the invoice id' do
          params[:invoice_id] = 'asd'
          put "/api/bookings/#{booking.id}", params, headers
          expect(JSON.parse(response.body)).to be_instance_of(Hash)
          expect(response.status).to eq(400)
        end
      end

      context 'invoice id is nil' do
        it 'does not care about a nil value' do
          params[:invoice_id] = nil
          put "/api/bookings/#{booking.id}", params, headers
          expect(response.status).to eq(200)
        end
      end
    end
  end

  describe 'DELETE /api/bookings/:id' do
    let(:params) { {} }
    let!(:booking) { FactoryGirl.create(:account_booking) }

    it 'removes the booking' do
      delete "/api/bookings/#{booking.id}", params, headers
      expect(response.body).to eq('')
      expect(response.status).to eq(204)
    end

    it 'creates a new booking' do
      expect { delete "/api/bookings/#{booking.id}", params, headers }.
        to change(Booking, :count).from(1).to(0)
    end
  end
end
