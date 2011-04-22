require 'spec_helper'

describe "employees/show.html.haml" do
  before(:each) do
    @employee = assign(:employee, Factory.create(:employee))
    @view.stub(:resource).and_return(@employee)
  end

  it "renders attributes in <p>" do
    pending "problem with paginated partial list employments"
    render
  end
end
