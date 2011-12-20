require 'spec_helper'

describe AttachmentsController do
  describe "routing" do
    before(:all) do
      @attachment = Factory.create(:attachment)
    end

    it "recognizes and generates #download" do
      {
        :get => "/attachments/#{@attachment.id}/download"
      }.should route_to(:controller =>  "attachments",
                        :action =>      "download",
                        :id =>          @attachment.id.to_s)
    end
  end
end
