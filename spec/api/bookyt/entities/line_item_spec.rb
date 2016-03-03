require 'spec_helper'

RSpec.describe Bookyt::Entities::LineItem do
  let(:line_item) { FactoryGirl.create(:banana) }
  let(:instance) { Bookyt::Entities::LineItem.represent(line_item) }

  subject { JSON.parse(instance.to_json) }

  it 'matches the api specification' do
    expect(subject).to eq(
      'id' => line_item.id,
      'title' => line_item.title,
      'price' => line_item.price.to_s,
      'credit_account_code' => line_item.credit_account.code,
      'debit_account_code' => line_item.debit_account.code,
      'date' => line_item.date,
      'quantity' => line_item.quantity,
      'times' => line_item.times.to_s,
      'total_amount' => '1.0',
    )
  end
end
