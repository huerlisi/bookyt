require 'spec_helper'

describe "tenants/show.html.haml" do
  before(:each) do
    @tenant = assign(:tenant, stub_model(Tenant))
  end

  it "renders attributes in <p>" do
    render
  end
end
