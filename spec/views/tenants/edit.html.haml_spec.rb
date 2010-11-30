require 'spec_helper'

describe "tenants/edit.html.haml" do
  before(:each) do
    @tenant = assign(:tenant, stub_model(Tenant,
      :new_record? => false
    ))
  end

  it "renders the edit tenant form" do
    render

    rendered.should have_selector("form", :action => tenant_path(@tenant), :method => "post") do |form|
    end
  end
end
