require 'spec_helper'

describe "tenants/edit.html.haml" do
  before(:each) do
    @tenant = assign(:tenant, stub_model(Tenant,
      :new_record? => false
    ))
  end

  it "renders the edit tenant form" do
    render

    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "form", :action => tenant_path(@tenant), :method => "post" do
    end
  end
end
