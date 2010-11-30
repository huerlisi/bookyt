require 'spec_helper'

describe "booking_imports/index.html.haml" do
  before(:each) do
    assign(:booking_imports, [
      stub_model(BookingImport, :created_at => DateTime.now),
      stub_model(BookingImport, :created_at => DateTime.now)
    ].paginate(:page => 1))
  end

  it "renders a list of booking_imports" do
    render
  end
end
