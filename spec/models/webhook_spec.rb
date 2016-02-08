require 'spec_helper'

RSpec.describe Webhook do
  let(:invoice) { FactoryGirl.create :debit_invoice }
  let(:event) { :paid }
  let(:instance) { Webhook.new(invoice, event) }
  before do
    FactoryGirl.create :tenant
  end

  describe '.call' do
    let(:webhook_double) { instance_double(described_class) }

    it 'initializes a new instance and calls `#call`' do
      expect(described_class).
        to receive(:new).with(invoice, event).and_return(webhook_double)
      expect(webhook_double).to receive(:call)
      described_class.call(invoice, event)
    end
  end

  describe '#call' do
    let(:faraday_double) { instance_double(Faraday::Connection) }
    let(:request_double) { instance_double(Faraday::Request) }
    let(:headers_double) { instance_double(Hash) }

    context 'webhook not configured' do
      before do
        Tenant.first.update_attributes webhook: nil
      end

      it 'does not send a webhook' do
        expect(Faraday).to_not receive(:new)
        instance.call
      end
    end

    context 'webhook configured' do
      before do
        Tenant.first.update_attributes webhook: 'http://webhook.test'
      end

      it 'calls the given webhook' do
        expect(Faraday).to receive(:new).and_yield(faraday_double).and_return(faraday_double)
        expect(faraday_double).to receive(:adapter).with(Faraday.default_adapter)

        expect(faraday_double).to receive(:post).and_yield(request_double)
        expect(request_double).to receive(:url).with(Tenant.first.webhook)
        expect(request_double).to receive(:headers).and_return(headers_double)
        expect(request_double).to receive(:body=).with({event: 'debit_invoice.paid', id: invoice.id}.to_json)

        expect(headers_double).to receive('[]=').with('Content-Type', 'application/json')

        instance.call
      end

      it 'returns gracefully if the call raises an error' do
        allow(faraday_double).to receive(:post).and_raise('Oops')
        expect(Rails.logger).to receive(:error).with(instance_of(String))
        expect { instance.call }.to_not raise_error
      end
    end
  end
end
