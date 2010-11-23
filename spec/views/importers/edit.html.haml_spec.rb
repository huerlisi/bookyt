require 'spec_helper'

describe "importers/edit.html.haml" do
  before(:each) do
    @importer = assign(:importer, stub_model(Importer,
      :new_record? => false
    ))
  end

  it "renders the edit importer form" do
    render

    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "form", :action => importer_path(@importer), :method => "post" do
    end
  end
end
