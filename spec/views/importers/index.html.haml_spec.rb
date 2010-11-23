require 'spec_helper'

describe "importers/index.html.haml" do
  before(:each) do
    assign(:importers, [
      stub_model(Importer),
      stub_model(Importer)
    ])
  end

  it "renders a list of importers" do
    render
  end
end
