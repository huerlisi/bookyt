require 'spec_helper'

describe AttachmentsController do
  describe "routing" do
    before(:all) do
      @attachment = FactoryGirl.create(:attachment)
    end

    it "recognizes and generates #download" do
      expect({
        :get => "/attachments/#{@attachment.id}/download"
      }).to route_to(:controller =>  "attachments",
                        :action =>      "download",
                        :id =>          @attachment.id.to_s)
    end
  end
end
