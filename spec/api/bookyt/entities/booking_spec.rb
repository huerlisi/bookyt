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
      'credit_account_code' => booking.credit_account.code,
      'debit_account_code' => booking.debit_account.code,
    )
  end
end
