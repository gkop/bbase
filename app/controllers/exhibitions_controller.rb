class ExhibitionsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  # POST /exhibitions/1/add/2
  def add
    @exhibition = Exhibition.find(params[:id])
    @artwork = Artwork.find(params[:artwork_id])
    @exhibition.artworks << @artwork
    if @exhibition && @artwork && @artwork.save
      flash[:notice] = "Added "+@artwork.title+" to "+@exhibition.name 
    else
      flash[:error] = "Error adding "+@artwork.title+" to "+@exhibition.name 
    end

    redirect_to @artwork 
  end

  # POST /exhibitions/1/add/2
  def remove
    @exhibition = Exhibition.find(params[:id])
    @artwork = Artwork.find(params[:artwork_id])
    @exhibition.artwork_ids.delete(@artwork.id)
    @artwork.exhibition_ids.delete(@exhibition.id)
    if @exhibition && @artwork && @exhibition.save && @artwork.save
      flash[:notice] = "Removed "+@artwork.title+" from "+@exhibition.name 
    else
      flash[:error] = "Error removing "+@artwork.title+" from "+@exhibition.name 
    end

    redirect_to @exhibition 
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
    @exhibition = Exhibition.new(params[:exhibition])
    current_user.exhibitions << @exhibition

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
    if params[:exhibition][:assigned_to_homepage]
      @exhibition.assign_to_homepage
    end

    respond_to do |format|
      if @exhibition.save! && @exhibition.update_attributes(params[:artwork])
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

    # the deleted exhibition may have been assigned to the homepage
    if Configuration.get('homepage_exhibition') == @exhibition.id
      Configuration.set('homepage_exhibition', nil)
    end

    flash[:notice] = "Deleted exhibition "+@exhibition.name 

    respond_to do |format|
      format.html { redirect_to(exhibitions_url) }
      format.xml  { head :ok }
    end
  end
end
