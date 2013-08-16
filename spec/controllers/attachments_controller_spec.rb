require 'spec_helper'

describe AttachmentsController do
  before(:all) do
    @attachment = FactoryGirl.create(:attachment)
  end
  it "redirects back after create" do
    post :create
  end
end
