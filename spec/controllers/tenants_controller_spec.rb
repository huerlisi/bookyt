require 'spec_helper'

describe TenantsController do

  def mock_tenant(stubs={})
    (@mock_tenant ||= mock_model(Tenant).as_null_object).tap do |tenant|
      tenant.stub(stubs) unless stubs.empty?
    end
  end

  describe "GET index" do
    it "assigns all tenants as @tenants" do
      Tenant.stub(:all) { [mock_tenant] }
      get :index
      assigns(:tenants).should eq([mock_tenant])
    end
  end

  describe "GET show" do
    it "assigns the requested tenant as @tenant" do
      Tenant.stub(:find).with("37") { mock_tenant }
      get :show, :id => "37"
      assigns(:tenant).should be(mock_tenant)
    end
  end

  describe "GET new" do
    it "assigns a new tenant as @tenant" do
      Tenant.stub(:new) { mock_tenant }
      get :new
      assigns(:tenant).should be(mock_tenant)
    end
  end

  describe "GET edit" do
    it "assigns the requested tenant as @tenant" do
      Tenant.stub(:find).with("37") { mock_tenant }
      get :edit, :id => "37"
      assigns(:tenant).should be(mock_tenant)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created tenant as @tenant" do
        Tenant.stub(:new).with({'these' => 'params'}) { mock_tenant(:save => true) }
        post :create, :tenant => {'these' => 'params'}
        assigns(:tenant).should be(mock_tenant)
      end

      it "redirects to the created tenant" do
        Tenant.stub(:new) { mock_tenant(:save => true) }
        post :create, :tenant => {}
        response.should redirect_to(tenant_url(mock_tenant))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved tenant as @tenant" do
        Tenant.stub(:new).with({'these' => 'params'}) { mock_tenant(:save => false) }
        post :create, :tenant => {'these' => 'params'}
        assigns(:tenant).should be(mock_tenant)
      end

      it "re-renders the 'new' template" do
        Tenant.stub(:new) { mock_tenant(:save => false) }
        post :create, :tenant => {}
        response.should render_template("new")
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested tenant" do
        Tenant.should_receive(:find).with("37") { mock_tenant }
        mock_tenant.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :tenant => {'these' => 'params'}
      end

      it "assigns the requested tenant as @tenant" do
        Tenant.stub(:find) { mock_tenant(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:tenant).should be(mock_tenant)
      end

      it "redirects to the tenant" do
        Tenant.stub(:find) { mock_tenant(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(tenant_url(mock_tenant))
      end
    end

    describe "with invalid params" do
      it "assigns the tenant as @tenant" do
        Tenant.stub(:find) { mock_tenant(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:tenant).should be(mock_tenant)
      end

      it "re-renders the 'edit' template" do
        Tenant.stub(:find) { mock_tenant(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested tenant" do
      Tenant.should_receive(:find).with("37") { mock_tenant }
      mock_tenant.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the tenants list" do
      Tenant.stub(:find) { mock_tenant }
      delete :destroy, :id => "1"
      response.should redirect_to(tenants_url)
    end
  end

end
