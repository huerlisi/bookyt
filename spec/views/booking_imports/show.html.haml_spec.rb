require 'spec_helper'

describe "booking_imports/show.html.haml" do
  before(:each) do
    @booking_import = assign(:booking_import, stub_model(BookingImport))
  end

  it "renders attributes in <p>" do
    render
  end
end
