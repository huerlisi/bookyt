require 'spec_helper'

shared_examples "note actions" do
  describe "interact with notes controller" do
    it "should list the notes" do
      employee = Factory.create(:employee)
      get :index, :employee_id => employee.id
      assigns(:note_of_sth).should_not be_nil
      assigns(:notes).should_not be_nil
    end

    pending "should display a new note" do
      get :new
    end
    
    pending "should create a note" do
      get :create
    end
  end
end

describe NotesController do
  context "as admin" do
    login_admin
    it_behaves_like "note actions"
  end

  context "as accountant" do
    login_accountant
    it_behaves_like "note actions"
  end
end
