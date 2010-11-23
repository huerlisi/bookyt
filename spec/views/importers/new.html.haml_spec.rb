require 'spec_helper'

describe "importers/new.html.haml" do
  before(:each) do
    assign(:importer, stub_model(Importer).as_new_record)
  end

  it "renders new importer form" do
    render

    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "form", :action => importers_path, :method => "post" do
    end
  end
end
