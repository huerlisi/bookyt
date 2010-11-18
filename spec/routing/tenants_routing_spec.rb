require "spec_helper"

describe TenantsController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/tenants" }.should route_to(:controller => "tenants", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/tenants/new" }.should route_to(:controller => "tenants", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/tenants/1" }.should route_to(:controller => "tenants", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/tenants/1/edit" }.should route_to(:controller => "tenants", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/tenants" }.should route_to(:controller => "tenants", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/tenants/1" }.should route_to(:controller => "tenants", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/tenants/1" }.should route_to(:controller => "tenants", :action => "destroy", :id => "1")
    end

  end
end
