require 'spec_helper'

describe ImportersController do

  def mock_importer(stubs={})
    (@mock_importer ||= mock_model(Importer).as_null_object).tap do |importer|
      importer.stub(stubs) unless stubs.empty?
    end
  end

  describe "GET index" do
    it "assigns all importers as @importers" do
      Importer.stub(:all) { [mock_importer] }
      get :index
      assigns(:importers).should eq([mock_importer])
    end
  end

  describe "GET show" do
    it "assigns the requested importer as @importer" do
      Importer.stub(:find).with("37") { mock_importer }
      get :show, :id => "37"
      assigns(:importer).should be(mock_importer)
    end
  end

  describe "GET new" do
    it "assigns a new importer as @importer" do
      Importer.stub(:new) { mock_importer }
      get :new
      assigns(:importer).should be(mock_importer)
    end
  end

  describe "GET edit" do
    it "assigns the requested importer as @importer" do
      Importer.stub(:find).with("37") { mock_importer }
      get :edit, :id => "37"
      assigns(:importer).should be(mock_importer)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created importer as @importer" do
        Importer.stub(:new).with({'these' => 'params'}) { mock_importer(:save => true) }
        post :create, :importer => {'these' => 'params'}
        assigns(:importer).should be(mock_importer)
      end

      it "redirects to the created importer" do
        Importer.stub(:new) { mock_importer(:save => true) }
        post :create, :importer => {}
        response.should redirect_to(importer_url(mock_importer))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved importer as @importer" do
        Importer.stub(:new).with({'these' => 'params'}) { mock_importer(:save => false) }
        post :create, :importer => {'these' => 'params'}
        assigns(:importer).should be(mock_importer)
      end

      it "re-renders the 'new' template" do
        Importer.stub(:new) { mock_importer(:save => false) }
        post :create, :importer => {}
        response.should render_template("new")
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested importer" do
        Importer.should_receive(:find).with("37") { mock_importer }
        mock_importer.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :importer => {'these' => 'params'}
      end

      it "assigns the requested importer as @importer" do
        Importer.stub(:find) { mock_importer(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:importer).should be(mock_importer)
      end

      it "redirects to the importer" do
        Importer.stub(:find) { mock_importer(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(importer_url(mock_importer))
      end
    end

    describe "with invalid params" do
      it "assigns the importer as @importer" do
        Importer.stub(:find) { mock_importer(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:importer).should be(mock_importer)
      end

      it "re-renders the 'edit' template" do
        Importer.stub(:find) { mock_importer(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested importer" do
      Importer.should_receive(:find).with("37") { mock_importer }
      mock_importer.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the importers list" do
      Importer.stub(:find) { mock_importer }
      delete :destroy, :id => "1"
      response.should redirect_to(importers_url)
    end
  end

end
