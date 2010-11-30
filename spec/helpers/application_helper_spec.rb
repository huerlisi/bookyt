require 'spec_helper'

describe ApplicationHelper do
  describe "contextual_links" do
    it "adds a div with class contextual" do
      helper.contextual_links.should have_selector('div.contextual')
    end
  end
end
