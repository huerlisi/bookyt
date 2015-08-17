require 'spec_helper'

describe EmployeesController do
  self.use_transactional_fixtures = false

  login_admin

  def mock_employee(stubs={})
    @mock_employee ||= mock_model(Employee, stubs).as_null_object
  end

  describe "GET index" do
    before(:all) do
      FactoryGirl.create(:employee)
    end

    it "assigns all employees as @employees" do
      get :index
      expect(assigns(:employees)).not_to be_empty
      expect(assigns(:employees).first).to be_a_kind_of(Employee)
    end
  end

  describe "GET show" do
    it "assigns the requested employee as @employee" do
      allow(Employee).to receive(:find).with("37") { mock_employee }
      get :show, :id => "37"
      expect(assigns(:employee)).to be(mock_employee)
    end
  end

  describe "GET new" do
    it "assigns a new employee as @employee" do
      allow(Employee).to receive(:new) { mock_employee }
      get :new
      expect(assigns(:employee)).to be(mock_employee)
    end
  end

  describe "GET edit" do
    it "assigns the requested employee as @employee" do
      allow(Employee).to receive(:find).with("37") { mock_employee }
      get :edit, :id => "37"
      expect(assigns(:employee)).to be(mock_employee)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created employee as @employee" do
        allow(Employee).to receive(:new).with({'these' => 'params'}) { mock_employee(:save => true) }
        post :create, :employee => {'these' => 'params'}
        expect(assigns(:employee)).to be(mock_employee)
      end

      it "redirects to the created employee" do
        allow(Employee).to receive(:new) { mock_employee(:save => true) }
        post :create, :employee => {}
        expect(response).to redirect_to(employee_url(mock_employee))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved employee as @employee" do
        allow(Employee).to receive(:new).with({'these' => 'params'}) { mock_employee(:save => false) }
        post :create, :employee => {'these' => 'params'}
        expect(assigns(:employee)).to be(mock_employee)
      end

      it "re-renders the 'new' template" do
        allow(Employee).to receive(:new) { mock_employee(:save => false) }
        post :create, :employee => {}
        expect(response).to render_template("new")
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested employee" do
        expect(Employee).to receive(:find).with("37") { mock_employee }
        expect(mock_employee).to receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :employee => {'these' => 'params'}
      end

      it "assigns the requested employee as @employee" do
        allow(Employee).to receive(:find) { mock_employee(:update_attributes => true) }
        put :update, :id => "1"
        expect(assigns(:employee)).to be(mock_employee)
      end

      it "redirects to the employee" do
        allow(Employee).to receive(:find) { mock_employee(:update_attributes => true) }
        put :update, :id => "1"
        expect(response).to redirect_to(employee_url(mock_employee))
      end
    end

    describe "with invalid params" do
      it "assigns the employee as @employee" do
        allow(Employee).to receive(:find) { mock_employee(:update_attributes => false) }
        put :update, :id => "1"
        expect(assigns(:employee)).to be(mock_employee)
      end

      it "re-renders the 'edit' template" do
        allow(Employee).to receive(:find) { mock_employee(:update_attributes => false) }
        put :update, :id => "1"
        expect(response).to render_template("edit")
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested employee" do
      expect(Employee).to receive(:find).with("37") { mock_employee }
      expect(mock_employee).to receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the employees list" do
      allow(Employee).to receive(:find) { mock_employee }
      delete :destroy, :id => "1"
      expect(response).to redirect_to(employees_url)
    end
  end

end
