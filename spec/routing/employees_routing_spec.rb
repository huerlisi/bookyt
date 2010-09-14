require "spec_helper"

describe EmployeesController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/employees" }.should route_to(:controller => "employees", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/employees/new" }.should route_to(:controller => "employees", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/employees/1" }.should route_to(:controller => "employees", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/employees/1/edit" }.should route_to(:controller => "employees", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/employees" }.should route_to(:controller => "employees", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/employees/1" }.should route_to(:controller => "employees", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/employees/1" }.should route_to(:controller => "employees", :action => "destroy", :id => "1")
    end

  end
end
