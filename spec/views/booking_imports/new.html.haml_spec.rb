require 'spec_helper'

describe "booking_imports/new.html.haml" do
  before(:each) do
    assign(:booking_import, stub_model(BookingImport).as_new_record)
  end

  it "renders new importer form" do
    render

    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "form", :action => booking_imports_path, :method => "post" do
    end
  end
end
