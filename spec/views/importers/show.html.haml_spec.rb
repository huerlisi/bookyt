require 'spec_helper'

describe "importers/show.html.haml" do
  before(:each) do
    @importer = assign(:importer, stub_model(Importer))
  end

  it "renders attributes in <p>" do
    render
  end
end
