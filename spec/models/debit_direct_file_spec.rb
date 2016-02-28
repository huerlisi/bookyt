require 'spec_helper'

RSpec.describe DebitDirectFile, :type => :model do
  it { is_expected.to have_many(:debit_invoices) }
  it { is_expected.to validate_presence_of(:content) }
end
