require "spec_helper"

describe EmployeesController do
  describe "routing" do

    it "recognizes and generates #index" do
      expect({ :get => "/employees" }).to route_to(:controller => "employees", :action => "index")
    end

    it "recognizes and generates #new" do
      expect({ :get => "/employees/new" }).to route_to(:controller => "employees", :action => "new")
    end

    it "recognizes and generates #show" do
      expect({ :get => "/employees/1" }).to route_to(:controller => "employees", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      expect({ :get => "/employees/1/edit" }).to route_to(:controller => "employees", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      expect({ :post => "/employees" }).to route_to(:controller => "employees", :action => "create")
    end

    it "recognizes and generates #update" do
      expect({ :put => "/employees/1" }).to route_to(:controller => "employees", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      expect({ :delete => "/employees/1" }).to route_to(:controller => "employees", :action => "destroy", :id => "1")
    end

  end
end
