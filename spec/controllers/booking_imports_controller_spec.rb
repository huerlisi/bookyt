require 'spec_helper'

describe BookingImportsController do
  login_admin

  def mock_booking_import(stubs={})
    @mock_booking_import ||= mock_model(BookingImport, stubs).as_null_object
  end

  describe "GET index" do
    pending "assigns all booking_imports as @booking_imports" do
      BookingImport.stub(:all) { [mock_booking_import] }
      get :index
      assigns(:booking_imports).should eq([mock_booking_import])
    end
  end

  describe "GET show" do
    it "assigns the requested booking_import as @booking_import" do
      BookingImport.stub(:find).with("37") { mock_booking_import }
      get :show, :id => "37"
      assigns(:booking_import).should be(mock_booking_import)
    end
  end

  describe "GET new" do
    it "assigns a new booking_import as @booking_import" do
      BookingImport.stub(:new) { mock_booking_import }
      get :new
      assigns(:booking_import).should be(mock_booking_import)
    end
  end

  describe "GET edit" do
    it "assigns the requested booking_import as @booking_import" do
      BookingImport.stub(:find).with("37") { mock_booking_import }
      get :edit, :id => "37"
      assigns(:booking_import).should be(mock_booking_import)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created booking_import as @booking_import" do
        BookingImport.stub(:new).with({'these' => 'params'}) { mock_booking_import(:save => true) }
        post :create, :booking_import => {'these' => 'params'}
        assigns(:booking_import).should be(mock_booking_import)
      end

      it "redirects to the created booking_import" do
        BookingImport.stub(:new) { mock_booking_import(:save => true) }
        post :create, :booking_import => {}
        response.should redirect_to(booking_import_url(mock_booking_import))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved booking_import as @booking_import" do
        BookingImport.stub(:new).with({'these' => 'params'}) { mock_booking_import(:save => false) }
        post :create, :booking_import => {'these' => 'params'}
        assigns(:booking_import).should be(mock_booking_import)
      end

      it "re-renders the 'new' template" do
        BookingImport.stub(:new) { mock_booking_import(:save => false) }
        post :create, :booking_import => {}
        response.should render_template("new")
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested booking_import" do
        BookingImport.should_receive(:find).with("37") { mock_booking_import }
        mock_booking_import.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :booking_import => {'these' => 'params'}
      end

      it "assigns the requested booking_import as @booking_import" do
        BookingImport.stub(:find) { mock_booking_import(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:booking_import).should be(mock_booking_import)
      end

      it "redirects to the booking_import" do
        BookingImport.stub(:find) { mock_booking_import(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(booking_import_url(mock_booking_import))
      end
    end

    describe "with invalid params" do
      it "assigns the booking_import as @booking_import" do
        BookingImport.stub(:find) { mock_booking_import(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:booking_import).should be(mock_booking_import)
      end

      it "re-renders the 'edit' template" do
        BookingImport.stub(:find) { mock_booking_import(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested booking_import" do
      BookingImport.should_receive(:find).with("37") { mock_booking_import }
      mock_booking_import.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the booking_booking_imports list" do
      BookingImport.stub(:find) { mock_booking_import }
      delete :destroy, :id => "1"
      response.should redirect_to(booking_imports_url)
    end
  end

end
