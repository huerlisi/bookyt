require 'spec_helper'

describe "tenants/new.html.haml" do
  before(:each) do
    assign(:tenant, stub_model(Tenant).as_new_record)
  end

  it "renders new tenant form" do
    render

    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "form", :action => tenants_path, :method => "post" do
    end
  end
end
