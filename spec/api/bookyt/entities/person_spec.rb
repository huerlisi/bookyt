require 'spec_helper'

RSpec.describe Bookyt::Entities::Person do
  let(:customer) { FactoryGirl.create(:customer) }
  let(:instance) { described_class.represent(customer) }

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
    )
  end
end
