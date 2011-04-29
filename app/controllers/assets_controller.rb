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
    asset_params.merge!(params[:asset] || {})

    @asset = Asset.new(asset_params)
  end
  
  def create
    @asset = Asset.new(params[:asset])
    @asset.build_booking
    
    create!
  end

  def write_downs
    # use current date if not specified otherwise
    params[:profit] ||= {}
    
    # use current date if not specified otherwise
    if params[:by_value_period]
      @end_date = Date.parse(params[:by_value_period][:to])
      @start_date = Date.parse(params[:by_value_period][:from])
    else
      @end_date = Date.today
      @start_date = @end_date.to_time.advance(:years => -1, :days => 1).to_date
    end

    @date = @start_date..@end_date

    @assets = Asset.all
    @assets = @assets.select{|asset|
      asset.balance(@start_date) != 0.0 or asset.balance(@end_date) != 0.0
    }
  end
end
