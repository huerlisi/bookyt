require 'spec_helper'

RSpec.describe Bookyt::Entities::DebitInvoice do
  let(:invoice) do
    FactoryGirl.create(:debit_invoice, due_date: '2015-10-10'.to_date, value_date: '2015-10-01'.to_date)
  end
  let(:instance) { Bookyt::Entities::DebitInvoice.represent(invoice) }

  subject { JSON.parse(instance.to_json) }

  it 'matches the api specification' do
    expect(subject).to eq(
      'id' => invoice.id,
      'title' => invoice.title,
      'customer_id' => invoice.customer.id,
      'state' => invoice.state,
      'value_date' => '2015-10-01',
      'due_date' => '2015-10-10',
      'duration_from' => nil,
      'duration_to' => nil,
      'text' => nil,
      'remarks' => nil,
      'line_items' => [],
    )
  end
end
