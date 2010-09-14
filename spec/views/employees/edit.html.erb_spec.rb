require 'spec_helper'

describe "employees/edit.html.erb" do
  before(:each) do
    @employee = assign(:employee, stub_model(Employee,
      :new_record? => false
    ))
  end

  it "renders the edit employee form" do
    render

    rendered.should have_selector("form", :action => employee_path(@employee), :method => "post") do |form|
    end
  end
end
