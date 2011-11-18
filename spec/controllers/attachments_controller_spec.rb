require 'spec_helper'

describe AttachmentsController do
  before(:all) do
    @attachment = Factory.create(:attachment)
  end
  it "redirects back after create" do
    post :create
  end
end
