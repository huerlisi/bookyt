require 'spec_helper'

describe AccountsController do
  describe "routing" do

    it "recognizes and generates #index" do
      expect({ :get => "/accounts" }).to route_to(:controller => "accounts", :action => "index")
    end

    it "recognizes and generates #new" do
      expect({ :get => "/accounts/new" }).to route_to(:controller => "accounts", :action => "new")
    end

    it "recognizes and generates #show" do
      expect({ :get => "/accounts/1" }).to route_to(:controller => "accounts", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      expect({ :get => "/accounts/1/edit" }).to route_to(:controller => "accounts", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      expect({ :post => "/accounts" }).to route_to(:controller => "accounts", :action => "create")
    end

    it "recognizes and generates #update" do
      expect({ :put => "/accounts/1" }).to route_to(:controller => "accounts", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      expect({ :delete => "/accounts/1" }).to route_to(:controller => "accounts", :action => "destroy", :id => "1")
    end

  end
end
