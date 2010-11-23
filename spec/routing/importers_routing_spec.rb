require "spec_helper"

describe ImportersController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/importers" }.should route_to(:controller => "importers", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/importers/new" }.should route_to(:controller => "importers", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/importers/1" }.should route_to(:controller => "importers", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/importers/1/edit" }.should route_to(:controller => "importers", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/importers" }.should route_to(:controller => "importers", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/importers/1" }.should route_to(:controller => "importers", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/importers/1" }.should route_to(:controller => "importers", :action => "destroy", :id => "1")
    end

  end
end
