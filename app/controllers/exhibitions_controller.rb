class ExhibitionsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  # POST /exhibitons/1/add/2
  def add
    @exhibition = Exhibition.find(params[:id])
    @artwork = Artwork.find(params[:artwork_id])
    @exhibition.artworks << @artwork
    if @exhibition && @artwork && @exhibition.save
      flash[:notice] = "Added "+@artwork.title+" to "+@exhibition.name 
    else
      flash[:error] = "Error adding "+@artwork.title+" to "+@exhibition.name 
    end

    redirect_to @artwork 
  end

  # GET /exhibitions
  # GET /exhibitions.xml
  def index
    @exhibitions = Exhibition.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @exhibitions }
    end
  end

  # GET /exhibitions/1
  # GET /exhibitions/1.xml
  def show
    @exhibition = Exhibition.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @exhibition }
    end
  end

  # GET /exhibitions/new
  # GET /exhibitions/new.xml
  def new
    @exhibition = Exhibition.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @exhibition }
    end
  end

  # GET /exhibitions/1/edit
  def edit
    @exhibition = Exhibition.find(params[:id])
  end

  # POST /exhibitions
  # POST /exhibitions.xml
  def create
    @exhibition = Exhibition.new(params[:artwork])

    respond_to do |format|
      if @exhibition.save
        format.html { redirect_to(@exhibition, :notice => 'Exhibition was successfully created.') }
        format.xml  { render :xml => @exhibition, :status => :created, :location => @artwork }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @exhibition.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /exhibitions/1
  # PUT /exhibitions/1.xml
  def update
    @exhibition = Exhibition.find(params[:id])

    respond_to do |format|
      if @exhibition.update_attributes(params[:artwork])
        format.html { redirect_to(@exhibition, :notice => 'Exhibition was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @exhibition.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /exhibitions/1
  # DELETE /exhibitions/1.xml
  def destroy
    @exhibition = Exhibition.find(params[:id])
    @exhibition.destroy

    respond_to do |format|
      format.html { redirect_to(exhibitions_url) }
      format.xml  { head :ok }
    end
  end
end
