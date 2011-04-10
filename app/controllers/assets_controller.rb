class AssetsController < AuthorizedController
  # States
  has_scope :by_state
  
  # Actions
  def create
    @asset = Asset.new(params[:asset])
    @asset.build_booking
    
    create!
  end
end
