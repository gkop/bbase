class GalleriesController < ApplicationController
  load_and_authorize_resource

  # POST /galleries/1/add/2
  def add
    @artwork = Artwork.find(params[:artwork_id])
    @gallery.artworks << @artwork
    if @gallery && @artwork && @artwork.save
      flash[:notice] = "Added "+@artwork.title+" to "+@gallery.name 
    else
      flash[:error] = "Error adding "+@artwork.title+" to "+@gallery.name 
    end

    redirect_to @artwork 
  end

  # POST /galleries/1/add/2
  def remove
    @gallery = Gallery.find(params[:id])
    @artwork = Artwork.find(params[:artwork_id])
    @gallery.artwork_ids.delete(@artwork.id)
    @artwork.gallery_ids.delete(@gallery.id)
    if @gallery && @artwork && @gallery.save && @artwork.save
      flash[:notice] = "Removed "+@artwork.title+" from "+@gallery.name 
    else
      flash[:error] = "Error removing "+@artwork.title+" from "+@gallery.name 
    end

    redirect_to @gallery 
  end

  # GET /galleries
  # GET /galleries.xml
  def index
    all_galleries = Gallery.non_empty
    @curated_galleries = all_galleries.curated.shuffle
    @uncurated_galleries = all_galleries.uncurated.shuffle
  end

  # GET /galleries/1
  # GET /galleries/1.xml
  def show
    @gallery = Gallery.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @gallery }
    end
  end

  # GET /galleries/new
  # GET /galleries/new.xml
  def new
    @gallery = Gallery.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @gallery }
    end
  end

  # GET /galleries/1/edit
  def edit
    @gallery = Gallery.find(params[:id])
  end

  # POST /galleries
  # POST /galleries.xml
  def create
    @gallery = Gallery.new(params[:gallery])
    current_user.galleries << @gallery
    if @gallery.save
      redirect_to(@gallery, :notice => I18n.t("galleries.successful_create"))
    else
      render :action => "new"
    end
  end

  # PUT /galleries/1
  # PUT /galleries/1.xml
  def update
    @gallery = Gallery.find(params[:id])
    if params[:gallery][:assigned_to_homepage]
      if current_user.admin?
        @gallery.assign_to_homepage
      else
        raise CanCan::AccessDenied
      end
    end

    if params[:gallery][:curated]
      if current_user.admin?
        @gallery.curated = params[:gallery][:curated]
      else
        raise CanCan::AccessDenied
      end
    end

    respond_to do |format|
      if @gallery.save! && @gallery.update_attributes(params[:gallery])
        format.html { redirect_to(@gallery, :notice => I18n.t("galleries.successful_update")) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @gallery.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /galleries/1
  # DELETE /galleries/1.xml
  def destroy
    @gallery = Gallery.find(params[:id])
    @gallery.destroy

    # the deleted gallery may have been assigned to the homepage
    if Settings.get('homepage_gallery') == @gallery.id
      Settings.set('homepage_gallery', nil)
    end

    flash[:notice] = "Deleted gallery "+@gallery.name 

    respond_to do |format|
      format.html { redirect_to(galleries_url) }
      format.xml  { head :ok }
    end
  end
end
