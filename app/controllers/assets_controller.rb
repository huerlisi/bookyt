class AssetsController < AuthorizedController
  # States
  has_scope :by_state, :default => 'available', :only => :index
  has_scope :by_text
  
  # Actions
  def new

    # Defaults
    asset_params = {
      :state  => 'available'
    }

    # Load and assign parent invoice
    if params[:invoice_id]
      invoice = Invoice.find(params[:invoice_id])
      asset_params.merge!(
        :title  => invoice.title,
        :amount => invoice.amount
      )
    end
    
    # Paramameters
    asset_params.merge!(params[:asset])

    @asset = Asset.new(asset_params)
  end
  
  def create
    @asset = Asset.new(params[:asset])
    @asset.build_booking
    
    create!
  end
end
