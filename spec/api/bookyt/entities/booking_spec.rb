require 'spec_helper'

RSpec.describe Bookyt::Entities::Booking do
  let(:booking) do
    FactoryGirl.build(:account_booking,
                      title: 'Test',
                      amount: 13.37,
                      comments: 'Comment',
                      value_date: '2015-11-19')
  end
  let(:instance) { Bookyt::Entities::Booking.represent(booking) }

  subject { JSON.parse(instance.to_json) }

  it 'matches the api specification' do
    expect(subject).to eq(
      'id' => booking.id,
      'title' => 'Test',
      'amount' => '13.37',
      'value_date' => '2015-11-19',
      'comments' => 'Comment',
      'credit_account_id' => booking.credit_account_id,
      'debit_account_id' => booking.debit_account_id,
    )
  end
end
