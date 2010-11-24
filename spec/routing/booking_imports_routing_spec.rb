require "spec_helper"

describe BookingImportsController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/booking_imports" }.should route_to(:controller => "booking_imports", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/booking_imports/new" }.should route_to(:controller => "booking_imports", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/booking_imports/1" }.should route_to(:controller => "booking_imports", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/booking_imports/1/edit" }.should route_to(:controller => "booking_imports", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/booking_imports" }.should route_to(:controller => "booking_imports", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/booking_imports/1" }.should route_to(:controller => "booking_imports", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/booking_imports/1" }.should route_to(:controller => "booking_imports", :action => "destroy", :id => "1")
    end

  end
end
