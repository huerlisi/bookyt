require 'spec_helper'

describe StaticPagesController do
  it "When not logged in I should be able to view the imprint page" do
    get :imprint
    expect(response).to be_success
  end
end
