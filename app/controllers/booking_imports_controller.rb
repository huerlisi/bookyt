class BookingImportsController < ApplicationController
  # GET /albums
  # GET /albums.xml
  def index
    @booking_imports = BookingImport.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml { render :xml => @importers }
    end
  end

  # GET /Importers/1
  # GET /Importers/1.xml
  def show
    @booking_import = BookingImport.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml { render :xml => @importer }
    end
  end

  # GET /Importers/new
  # GET /Importers/new.xml
  def new
    @booking_import = BookingImport.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml { render :xml => @booking_import }
    end
  end

  # GET /Importers/1/edit
  def edit
    @booking_import = BookingImport.find(params[:id])
  end

  # POST /Importers
  # POST /Importers.xml
  def create
    @booking_import = BookingImport.new(params[:booking_import])

    respond_to do |format|
      if @booking_import.save
        format.html { redirect_to(@booking_import, :notice => 'BookingImport was successfully created.') }
        format.xml { render :xml => @booking_import, :status => :created, :location => @booking_import }
        format.js
      else
        format.html { render :action => "new" }
        format.xml { render :xml => @booking_import.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /Importers/1
  # PUT /Importers/1.xml
  def update
    @booking_import = BookingImport.find(params[:id])

    respond_to do |format|
      if @booking_import.update_attributes(params[:booking_import])
        format.html { redirect_to(@booking_import, :notice => 'BookingImport was successfully updated.') }
        format.xml { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml { render :xml => @booking_import.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /Importers/1
  # DELETE /Importers/1.xml
  def destroy
    @booking_import = BookingImport.find(params[:id])
    @booking_import.destroy

    respond_to do |format|
      format.html { redirect_to(booking_imports_url) }
      format.xml { head :ok }
    end
  end
end
