require 'spec_helper'

RSpec.describe Bookyt::Entities::Customer do
  let(:customer) do
    FactoryGirl.create(:customer, direct_debit_enabled: true, bank_account: 1, clearing: 2)
  end
  let(:instance) { Bookyt::Entities::Customer.represent(customer) }

  subject { JSON.parse(instance.to_json) }

  it 'matches the api specification' do
    expect(subject).to eq(
      'id' => customer.id,
      'city' => 'Capital',
      'extended_address' => nil,
      'name' => 'Muster Peter',
      'phone_numbers' => [],
      'post_office_box' => nil,
      'street' => 'Teststr. 1',
      'zip' => '9999',
      'direct_debit_enabled' => true,
      'bank_account_number' => 1,
      'bank_clearing_number' => 2,
    )
  end
end
