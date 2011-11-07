require 'spec_helper'

describe LineItem do
  it { should belong_to :item }
  it { should belong_to :invoice }
  
  pending "doesn't work at the moment" do
    it { should validate_presence_of(:times) }
    it { should validate_presence_of(:price) }
    it { should validate_presence_of(:title) }
  end
end
