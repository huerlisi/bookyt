require 'spec_helper'

RSpec.describe Bookyt::Entities::DebitDirectFile do
  let(:debit_direct_file) do
    FactoryGirl.create(:debit_direct_file)
  end
  let(:instance) { Bookyt::Entities::DebitDirectFile.represent(debit_direct_file) }

  subject { JSON.parse(instance.to_json) }

  it 'matches the api specification' do
    expect(subject).to eq(
      'id' => debit_direct_file.id,
      'title' => debit_direct_file.to_s,
      'content' => debit_direct_file.content,
    )
  end
end
