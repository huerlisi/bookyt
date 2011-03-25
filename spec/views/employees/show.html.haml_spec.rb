require 'spec_helper'

describe "employees/show.html.haml" do
  before(:each) do
    @employee = assign(:employee, stub_model(Employee))
    @view.stub(:resource).and_return(@employee)
  end

  it "renders attributes in <p>" do
    render
  end
end
