class AccountsController < InheritedResources::Base
  # inplace editor declarations
  in_place_edit_for :booking, :title
  in_place_edit_for :booking, :comments
  in_place_edit_for :booking, :in_place_amount
  in_place_edit_for :booking, :in_place_value_date
  
  def index
    @accounts = Account.paginate :page => params[:page], :per_page => 50, :order => 'number'
    index!
  end
end
