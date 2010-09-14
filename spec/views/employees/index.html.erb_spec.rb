require 'spec_helper'

describe "employees/index.html.erb" do
  before(:each) do
    assign(:employees, [
      stub_model(Employee),
      stub_model(Employee)
    ])
  end

  it "renders a list of employees" do
    render
  end
end
