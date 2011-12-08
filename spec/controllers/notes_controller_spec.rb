require 'spec_helper'

shared_examples "note actions" do
  describe "interact with notes controller" do
    it "should list the notes" do
      get :index, :employee_id => @employee.id
      assigns(:note_of_sth).should_not be_nil
      assigns(:notes).should_not be_nil
      assigns(:notes).should_not be_empty
    end

    it "should display a new note" do
      get :new, :employee_id => @employee.id
      response.should render_template('new')
      assigns(:note).should_not be_nil
      assigns(:note).should be_a_kind_of(Note)
      assigns(:note).user.should eq(@current_user)
    end

    it "should create a note" do
      post :create, {:employee_id => @employee.id, :note => {:content => 'Comment'}}
      response.should redirect_to(employee_notes_path(@employee))
    end
  end
end

describe NotesController do
  before(:all) do
    @employee = Factory.create(:employee)
  end

  context "as admin" do
    login_admin
    it_behaves_like "note actions"
  end

  context "as accountant" do
    login_accountant
    it_behaves_like "note actions"
  end
end
