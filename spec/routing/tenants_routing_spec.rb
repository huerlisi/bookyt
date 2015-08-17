require "spec_helper"

describe TenantsController do
  describe "routing" do

    it "recognizes and generates #index" do
      expect({ :get => "/tenants" }).to route_to(:controller => "tenants", :action => "index")
    end

    it "recognizes and generates #new" do
      expect({ :get => "/tenants/new" }).to route_to(:controller => "tenants", :action => "new")
    end

    it "recognizes and generates #show" do
      expect({ :get => "/tenants/1" }).to route_to(:controller => "tenants", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      expect({ :get => "/tenants/1/edit" }).to route_to(:controller => "tenants", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      expect({ :post => "/tenants" }).to route_to(:controller => "tenants", :action => "create")
    end

    it "recognizes and generates #update" do
      expect({ :put => "/tenants/1" }).to route_to(:controller => "tenants", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      expect({ :delete => "/tenants/1" }).to route_to(:controller => "tenants", :action => "destroy", :id => "1")
    end

  end
end
