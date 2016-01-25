require 'spec_helper'

RSpec.describe DebitDirectFileCreator do
  let(:tenant) { FactoryGirl.create :tenant, :debit_direct_identification => 'SOME1' }
  let(:bank_account) { FactoryGirl.create :bank_account, esr_id: '12000000' }
  let(:customer) { FactoryGirl.create(:customer, :direct_debit) }
  let!(:invoice) { FactoryGirl.create :debit_invoice, :customer => customer }
  let(:instance) { described_class.new(tenant, bank_account) }

  describe '.call' do
    let(:debit_direct_file_creator_double) { instance_double(described_class) }

    it 'initializes a new instance and calls `#call`' do
      expect(described_class).
        to receive(:new).with(tenant, bank_account).and_return(debit_direct_file_creator_double)
      expect(debit_direct_file_creator_double).to receive(:call)
      described_class.call(tenant, bank_account)
    end
  end

  describe '#call' do
    it 'creates a new DebitDirectFile' do
      expect { instance.call }.to change(DebitDirectFile, :count).from(0).to(1)
    end

    it 'assigns the included DebitInvoices to new DebitDirectFile' do
      expect { instance.call }.to change { invoice.reload.debit_direct_file_id }.from(nil)
    end

    it 'returns the newly created DebitDirectFile' do
      expect(instance.call).to be_a(DebitDirectFile)
    end
  end

  describe '#debit_invoices' do
    subject { instance.debit_invoices }

    it 'returns invoices without a debit direct file, but with a customer with direct debit' do
      invoice2 = FactoryGirl.create :debit_invoice, :debit_direct_file => FactoryGirl.create(:debit_direct_file), :customer => customer
      invoice3 = FactoryGirl.create :debit_invoice
      invoice4 = FactoryGirl.create :debit_invoice, :customer => customer, :state => 'paid'

      expect(subject).to include(invoice)
      expect(subject).to_not include(invoice2)
      expect(subject).to_not include(invoice3)
      expect(subject).to_not include(invoice4)
    end
  end

  describe '#content' do
    let(:customer) { FactoryGirl.create(:customer, :direct_debit) }
    let!(:invoice) { FactoryGirl.create :debit_invoice, :customer => customer }
    let(:lsvplus_file_double) { instance_double(LSVplus::File) }

    before do
      allow(LSVplus::File).to receive(:new).and_return(lsvplus_file_double)
      allow(lsvplus_file_double).to receive(:add_record)
      allow(lsvplus_file_double).to receive(:to_s).and_return('asd')
    end

    it 'calls add_record on the LSVplus::File for each record' do
      expect(lsvplus_file_double).to receive(:add_record).with(instance_of(LSVplus::Record))
      instance.content
    end

    it 'calls to_s on the LSVplus::File and returns the value' do
      expect(lsvplus_file_double).to receive(:to_s).and_return('asd')
      expect(instance.content).to eq('asd')
    end
  end

  describe '#lsv_record' do
    subject { instance.lsv_record(invoice) }

    let(:lsvplus_record) do
      LSVplus::Record.new(
        :processing_date => Date.today + 1,
        :creditor_bank_clearing_number => bank_account.bank.clearing,
        :amount => invoice.amount,
        :debitor_bank_clearing_number => invoice.customer.clearing,
        :creditor_iban => bank_account.iban,
        :creditor_address => [
          tenant.company.vcard.full_name,
          tenant.company.vcard.street_address,
          "#{tenant.company.vcard.postal_code} #{tenant.company.vcard.locality}",
        ],
        :debitor_account => invoice.customer.bank_account,
        :debitor_address => [
          invoice.customer.vcard.full_name,
          invoice.customer.vcard.street_address,
          "#{invoice.customer.vcard.postal_code} #{invoice.customer.vcard.locality}",
        ],
        :message => invoice.title,
        :reference_type => 'A',
        :reference => 'esr-number',
        :esr_member_id => bank_account.esr_id,
      )
    end

    before do
      allow(instance).to receive(:reference).with(invoice).and_return('esr-number')
    end

    it { is_expected.to eq(lsvplus_record) }
  end

  describe '#reference' do
    it 'calls VESR::ReferenceBuilder and VESR::ValidationDigitCalculator' do
      expect(VESR::ReferenceBuilder).
        to receive(:call).with(customer.id, invoice.id, bank_account.esr_id).and_return('1').ordered
      expect(VESR::ValidationDigitCalculator).to receive(:call).with('1').and_return('11').ordered
      expect(instance.reference(invoice)).to eq('11')
    end
  end
end
