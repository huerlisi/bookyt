require 'spec_helper'

describe "booking_imports/edit.html.haml" do
  before(:each) do
    @booking_import = assign(:booking_import, stub_model(BookingImport,
      :new_record? => false
    ))
  end

  it "renders the edit importer form" do
    render

    rendered.should have_selector("form", :action => booking_import_path(@booking_import), :method => "post") do |form|
    end
  end
end
