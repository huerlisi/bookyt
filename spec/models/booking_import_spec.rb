require 'spec_helper'

describe BookingImport do
  it { should have_attached_file(:csv) }
end
