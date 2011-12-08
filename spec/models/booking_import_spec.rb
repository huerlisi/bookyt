require 'spec_helper'

describe BookingImport do
  it { should have_attached_file(:csv) }

  it { should validate_presence_of(:csv)}
end
