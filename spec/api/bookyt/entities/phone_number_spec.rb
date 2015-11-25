require 'spec_helper'

RSpec.describe Bookyt::Entities::PhoneNumber do
  let(:customer) { FactoryGirl.create(:customer) }
  let(:phone_number) { customer.vcard.contacts.first }
  let(:instance) { Bookyt::Entities::PhoneNumber.represent(phone_number) }

  subject { JSON.parse(instance.to_json) }

  before do
    customer.vcard.contacts.create phone_number_type: 'Tel. privat', number: '1234'
  end

  it 'matches the api specification' do
    expect(subject).to eq(
      'type' => 'private',
      'number' => '1234',
    )
  end
end
