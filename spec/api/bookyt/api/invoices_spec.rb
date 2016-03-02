require 'spec_helper'

RSpec.describe Bookyt::API::Invoices, type: :request do
  let(:company) { FactoryGirl.create :company }
  let(:tenant) { FactoryGirl.create :tenant, company: company }
  let(:user) { FactoryGirl.create(:user, tenant: tenant) }
  let(:auth_token) { user.authentication_token }
  let(:headers) do
    { 'Auth-Token' => auth_token }
  end

  describe 'GET /api/invoices' do
    let(:params) { {} }
    let!(:invoice) { FactoryGirl.create(:debit_invoice) }

    it 'returns the invoices' do
      get '/api/invoices', params, headers
      expect(JSON.parse(response.body)).to be_instance_of(Array)
      expect(response.status).to eq(200)
    end

    it 'uses Bookyt::Entities::Invoice to display the Invoice' do
      expect(Bookyt::Entities::Invoice).to receive(:represent)
      get '/api/invoices', params, headers
    end
  end

  describe 'POST /api/invoices' do
    let(:customer) { FactoryGirl.create :customer }
    let(:params) do
      {
        title: 'a-123',
        address_id: customer.id,
        type: 'debit',
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

    it 'returns the created invoice' do
      post '/api/invoices', params, headers
      expect(JSON.parse(response.body)).to be_instance_of(Hash)
      expect(response.status).to eq(201)
    end

    it 'uses Bookyt::Entities::Invoice to display the created Invoice' do
      expect(Bookyt::Entities::Invoice).to receive(:represent)
      post '/api/invoices', params, headers
    end

    context 'DebitInvoice' do
      before do
        params[:address_id] = customer.id
        params[:type] = 'debit'
      end

      it 'creates a new debit invoice' do
        expect { post '/api/invoices', params, headers }.to change(DebitInvoice, :count).from(0).to(1)
      end
    end

    context 'CreditInvoice' do
      before do
        params[:address_id] = company.id
        params[:type] = 'credit'
      end

      it 'creates a new credit invoice' do
        expect { post '/api/invoices', params, headers }.to change(CreditInvoice, :count).from(0).to(1)
      end
    end
  end

  describe 'GET /api/invoices/:id' do
    let(:params) { {} }
    let!(:invoice) { FactoryGirl.create(:debit_invoice) }

    context 'accounts present' do
      it 'returns the invoice' do
        get "/api/invoices/#{invoice.id}", params, headers
        expect(JSON.parse(response.body)).to be_instance_of(Hash)
        expect(response.status).to eq(200)
      end

      it 'uses Bookyt::Entities::Invoice to display the Invoice' do
        expect(Bookyt::Entities::Invoice).to receive(:represent)
        get "/api/invoices/#{invoice.id}", params, headers
      end
    end
  end

  describe 'GET /api/invoices/:id/pdf' do
    let(:params) { {} }
    let!(:invoice) { FactoryGirl.create(:debit_invoice) }
    let!(:payment_account) { FactoryGirl.create(:bank_account, tag_list: %w(invoice:payment)) }

    context 'DebitInvoice' do
      it 'returns the invoice as pdf' do
        get "/api/invoices/#{invoice.id}/pdf", params, headers
        expect(response.content_type).to eq('application/pdf')
        expect(response.headers['Content-Disposition']).to match(/\Aattachment; filename=.+\.pdf/)
        expect(response.status).to eq(200)
      end
    end

    context 'CreditInvoice' do
      let!(:invoice) { FactoryGirl.create(:credit_invoice) }
      it 'returns 404' do
        get "/api/invoices/#{invoice.id}/pdf", params, headers
        expect(response.status).to eq(404)
      end
    end
  end

  describe 'PUT /api/invoices/:id' do
    let(:customer) { FactoryGirl.create :customer }
    let(:params) do
      {
        title: 'a-123',
        address_id: customer.id,
        type: 'debit',
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

    let!(:invoice) { FactoryGirl.create(:debit_invoice) }
    before do
      FactoryGirl.create(:account, tag_list: 'subscription:swag:full:credit')
      FactoryGirl.create(:account, tag_list: 'subscription:swag:full:debit')
    end

    it 'returns the updated invoice' do
      put "/api/invoices/#{invoice.id}", params, headers
      expect(JSON.parse(response.body)).to be_instance_of(Hash)
      expect(response.status).to eq(200)
    end

    it 'updates the invoice' do
      expect { put "/api/invoices/#{invoice.id}", params, headers }.
        to change { invoice.reload.title }
    end

    it 'uses Bookyt::Entities::Invoice to display the updated Invoice' do
      expect(Bookyt::Entities::Invoice).to receive(:represent)
      put "/api/invoices/#{invoice.id}", params, headers
    end

    it 'does not allow updating the company' do
      params[:address_id] = customer.id
      expect { put "/api/invoices/#{invoice.id}", params, headers }.
        to_not change { invoice.reload.company_id }
    end

    it 'does not allow updating the customer' do
      params[:address_id] = company.id
      expect { put "/api/invoices/#{invoice.id}", params, headers }.
        to_not change { invoice.reload.customer_id }
    end

    it 'does not allow updating the type' do
      params[:type] = 'credit'
      expect { put "/api/invoices/#{invoice.id}", params, headers }.
        to_not change { Invoice.find(invoice.id).class }
    end
  end

  describe 'DELETE /api/invoices/:id' do
    let(:params) { {} }
    let!(:invoice) { FactoryGirl.create(:debit_invoice) }

    it 'removes the invoice' do
      delete "/api/invoices/#{invoice.id}", params, headers
      expect(response.body).to eq('')
      expect(response.status).to eq(204)
    end

    it 'removes the invoice' do
      expect { delete "/api/invoices/#{invoice.id}", params, headers }.
        to change(Invoice, :count).from(1).to(0)
    end
  end
end
