class AccountTypesController < ApplicationController
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @account_type_pages, @account_types = paginate :account_types, :per_page => 10
  end

  def show
    @account_type = AccountType.find(params[:id])
  end

  def new
    @account_type = AccountType.new
  end

  def create
    @account_type = AccountType.new(params[:account_type])
    if @account_type.save
      flash[:notice] = 'AccountType was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @account_type = AccountType.find(params[:id])
  end

  def update
    @account_type = AccountType.find(params[:id])
    if @account_type.update_attributes(params[:account_type])
      flash[:notice] = 'AccountType was successfully updated.'
      redirect_to :action => 'show', :id => @account_type
    else
      render :action => 'edit'
    end
  end

  def destroy
    AccountType.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
