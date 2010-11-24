require 'spec_helper'

describe "booking_imports/edit.html.haml" do
  before(:each) do
    @importer = assign(:booking_import, stub_model(BookingImport,
      :new_record? => false
    ))
  end

  it "renders the edit importer form" do
    render

    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "form", :action => booking_import_path(@booking_import), :method => "post" do
    end
  end
end
