require 'spec_helper'

describe "employees/new.html.erb" do
  before(:each) do
    assign(:employee, stub_model(Employee,
      :new_record? => true
    ))
  end

  it "renders new employee form" do
    render

    rendered.should have_selector("form", :action => employees_path, :method => "post") do |form|
    end
  end
end
