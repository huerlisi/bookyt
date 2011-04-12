class AssetsController < AuthorizedController
  # States
  has_scope :by_state, :default => 'available', :only => :index
  has_scope :by_text
  
  # Actions
  def create
    @asset = Asset.new(params[:asset])
    @asset.build_booking
    
    create!
  end
end
