require "stringify_tags"

class ArtworksController < ApplicationController
  load_and_authorize_resource

  # GET /artworks
  def index
    if params[:tags].present?
      tags_array = params[:tags].split(',')
      @artworks = Artwork.tagged_with_any(tags_array)
      @title = StringifyTags.stringify(tags_array)
    else
      @artworks = Artwork.all
    end
    @artworks = @artworks.asc(:title)
  end

  # GET /artworks/1
  def show
    @artwork = Artwork.find(params[:id])
    @gallery = Gallery.find(params[:gallery_id]) if params[:gallery_id]
  end

  # GET /artworks/new
  def new
    @artwork = Artwork.new
  end

  # GET /artworks/1/edit
  def edit
    @artwork = Artwork.find(params[:id])
  end

  # POST /artworks
  def create
    @artwork = Artwork.new(params[:artwork])

    if @artwork.save
      redirect_to(@artwork, :notice => 'Artwork was successfully created.')
    else
      render :action => "new"
    end
  end

  # PUT /artworks/1
  def update
    @artwork = Artwork.find(params[:id])

    if @artwork.update_attributes(params[:artwork])
      redirect_to(@artwork, :notice => 'Artwork was successfully updated.')
    else
      render :action => "edit"
    end
  end

  # DELETE /artworks/1
  def destroy
    @artwork = Artwork.find(params[:id])
    @artwork.destroy

    redirect_to(artworks_url, notice: "Deleted artwork "+@artwork.title)
  end
end
