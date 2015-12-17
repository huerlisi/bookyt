require 'spec_helper'

RSpec.describe Bookyt::API::DebitInvoices, type: :request do
  let(:user) { FactoryGirl.create(:user) }
  let(:auth_token) { user.authentication_token }
  let(:headers) do
    { 'Auth-Token' => auth_token }
  end

  describe 'GET /api/debit_invoices' do
    let(:params) { {} }
    let!(:debit_invoice) { FactoryGirl.create(:debit_invoice) }

    it 'returns the debit_invoices' do
      get '/api/debit_invoices', params, headers
      expect(JSON.parse(response.body)).to be_instance_of(Array)
      expect(response.status).to eq(200)
    end

    it 'uses Bookyt::Entities::DebitInvoice to display the DebitInvoice' do
      expect(Bookyt::Entities::DebitInvoice).to receive(:represent)
      get '/api/debit_invoices', params, headers
    end
  end

  describe 'POST /api/debit_invoices' do
    let(:customer) { FactoryGirl.create :customer }
    let(:params) do
      {
        title: 'a-123',
        customer_id: customer.id,
        state: 'booked',
        value_date: '2015-10-01',
        due_date: '2015-10-10',
        duration_from: '2015-09-01',
        duration_to: '2015-09-30',
        text: 'Thank you for your money',
        remarks: 'Hopefully the customer never sees this remark',
        line_items: [
          title: 'SWAG subscription FULL',
          times: 5,
          quantity: 'x',
          price: 42.00,
          credit_account_tag: 'subscription:swag:full:credit',
          debit_account_tag: 'subscription:swag:full:debit',
        ],
      }
    end

    before do
      FactoryGirl.create(:account, tag_list: 'subscription:swag:full:credit')
      FactoryGirl.create(:account, tag_list: 'subscription:swag:full:debit')
    end

    it 'returns the created debit_invoice' do
      post '/api/debit_invoices', params, headers
      expect(JSON.parse(response.body)).to be_instance_of(Hash)
      expect(response.status).to eq(201)
    end

    it 'creates a new debit_invoice' do
      expect { post '/api/debit_invoices', params, headers }.to change(DebitInvoice, :count).from(0).to(1)
    end

    it 'uses Bookyt::Entities::DebitInvoice to display the created DebitInvoice' do
      expect(Bookyt::Entities::DebitInvoice).to receive(:represent)
      post '/api/debit_invoices', params, headers
    end
  end

  describe 'GET /api/debit_invoices/:id' do
    let(:params) { {} }
    let!(:debit_invoice) { FactoryGirl.create(:debit_invoice) }

    context 'accounts present' do
      it 'returns the debit_invoice' do
        get "/api/debit_invoices/#{debit_invoice.id}", params, headers
        expect(JSON.parse(response.body)).to be_instance_of(Hash)
        expect(response.status).to eq(200)
      end

      it 'uses Bookyt::Entities::DebitInvoice to display the DebitInvoice' do
        expect(Bookyt::Entities::DebitInvoice).to receive(:represent)
        get "/api/debit_invoices/#{debit_invoice.id}", params, headers
      end
    end
  end

  describe 'GET /api/debit_invoices/:id/pdf' do
    let(:params) { {} }
    let!(:debit_invoice) { FactoryGirl.create(:debit_invoice) }
    let!(:payment_account) { FactoryGirl.create(:bank_account, tag_list: %w(invoice:payment)) }

    context 'accounts present' do
      it 'returns the debit_invoice as pdf' do
        get "/api/debit_invoices/#{debit_invoice.id}/pdf", params, headers
        expect(response.content_type).to eq('application/pdf')
        expect(response.headers['Content-Disposition']).to match(/\Aattachment; filename=.+\.pdf/)
        expect(response.status).to eq(200)
      end
    end
  end

  describe 'PUT /api/debit_invoices/:id' do
    let(:customer) { FactoryGirl.create :customer }
    let(:params) do
      {
        title: 'a-123',
        customer_id: customer.id,
        state: 'booked',
        value_date: '2015-10-01',
        due_date: '2015-10-10',
        duration_from: '2015-09-01',
        duration_to: '2015-09-30',
        text: 'Thank you for your money',
        remarks: 'Hopefully the customer never sees this remark',
        line_items: [
          title: 'SWAG subscription FULL',
          times: 5,
          quantity: 'x',
          price: 42.00,
          credit_account_tag: 'subscription:swag:full:credit',
          debit_account_tag: 'subscription:swag:full:debit',
        ],
      }
    end

    let!(:debit_invoice) { FactoryGirl.create(:debit_invoice) }
    before do
      FactoryGirl.create(:account, tag_list: 'subscription:swag:full:credit')
      FactoryGirl.create(:account, tag_list: 'subscription:swag:full:debit')
    end

    it 'returns the updated debit_invoice' do
      put "/api/debit_invoices/#{debit_invoice.id}", params, headers
      expect(JSON.parse(response.body)).to be_instance_of(Hash)
      expect(response.status).to eq(200)
    end

    it 'updates the debit_invoice' do
      expect { put "/api/debit_invoices/#{debit_invoice.id}", params, headers }.
        to change { debit_invoice.reload.title }
    end

    it 'uses Bookyt::Entities::DebitInvoice to display the updated DebitInvoice' do
      expect(Bookyt::Entities::DebitInvoice).to receive(:represent)
      put "/api/debit_invoices/#{debit_invoice.id}", params, headers
    end
  end

  describe 'DELETE /api/debit_invoices/:id' do
    let(:params) { {} }
    let!(:debit_invoice) { FactoryGirl.create(:debit_invoice) }

    it 'removes the debit_invoice' do
      delete "/api/debit_invoices/#{debit_invoice.id}", params, headers
      expect(response.body).to eq('')
      expect(response.status).to eq(204)
    end

    it 'creates a new debit_invoice' do
      expect { delete "/api/debit_invoices/#{debit_invoice.id}", params, headers }.
        to change(DebitInvoice, :count).from(1).to(0)
    end
  end
end
