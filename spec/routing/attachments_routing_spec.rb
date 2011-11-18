require 'spec_helper'

describe AttachmentsController do
  describe "routing" do
    before(:all) do
      @attachment = Factory.create(:attachment)
    end

    it "recognizes and generates #download" do
      { 
        :get => "/uploads/#{@attachment.object.class.to_s.underscore}/#{@attachment.id}/letter.pdf" 
      }.should route_to(:controller =>  "attachments", 
                        :action =>      "download", 
                        :model =>       'employee', 
                        :basename =>    'letter', 
                        :extension =>   'pdf',
                        :conditions =>  {'method' => :get},
                        :id =>          @attachment.id.to_s)
    end
  end
end
