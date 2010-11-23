class ImportersController < ApplicationController
  # GET /albums
  # GET /albums.xml
  def index
    @importers = Importer.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml { render :xml => @importers }
    end
  end

  # GET /Importers/1
  # GET /Importers/1.xml
  def show
    @importer = Importer.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml { render :xml => @importer }
    end
  end

  # GET /Importers/new
  # GET /Importers/new.xml
  def new
    @importer = Importer.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml { render :xml => @importer }
    end
  end

  # GET /Importers/1/edit
  def edit
    @importer = Importer.find(params[:id])
  end

  # POST /Importers
  # POST /Importers.xml
  def create
    @importer = Importer.new(params[:importer])

    respond_to do |format|
      if @importer.save
        format.html { redirect_to(@importer, :notice => 'Importer was successfully created.') }
        format.xml { render :xml => @importer, :status => :created, :location => @importer }
        format.js
      else
        format.html { render :action => "new" }
        format.xml { render :xml => @importer.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /Importers/1
  # PUT /Importers/1.xml
  def update
    @importer = Importer.find(params[:id])

    respond_to do |format|
      if @importer.update_attributes(params[:importer])
        format.html { redirect_to(@importer, :notice => 'Importer was successfully updated.') }
        format.xml { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml { render :xml => @importer.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /Importers/1
  # DELETE /Importers/1.xml
  def destroy
    @importer = Importer.find(params[:id])
    @importer.destroy

    respond_to do |format|
      format.html { redirect_to(importers_url) }
      format.xml { head :ok }
    end
  end
end
