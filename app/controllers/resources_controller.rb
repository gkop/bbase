require "stringify_tags"

class ResourcesController < ApplicationController
  authorize_resource

  # GET /resources?tags=writing
  def index
    if params[:tags].present?
      tags_array = params[:tags].split(',')
      @resources = Resource.tagged_with_any(tags_array)
      @title = StringifyTags.stringify(tags_array)
    else
      @resources = Resource.all
    end
    @resources = @resources.asc(:sort_order)
  end

  # GET /resource/1
  def show
    @resource = Resource.find(params[:id])
  end

  # GET /resources/new?tag=writing
  def new
    @resource = Resource.new(:tags => params[:tag])
    @title = "New #{@resource.type}"
  end

  # GET /resources/1/edit
  def edit
    @resource = Resource.find(params[:id])
    @title = "Edit #{@resource.title}"
  end

  # POST /resources
  def create
    @resource = Resource.new(params[:resource])

    if @resource.save
      redirect_to(@resource, :notice => "#{@resource.type} was successfully created.")
    else
      params[:tag] = @resource.primary_tag
      render :action => "new"
    end
  end

  # PUT /resources/1
  def update
    @resource = Resource.find(params[:id])

    if @resource.update_attributes(params[:resource])
      redirect_to(@resource, :notice => "#{@resource.type} was successfully updated.")
    else
      render :action => "edit"
    end
  end

  # DELETE /resources/1
  def destroy
    @resource = Resource.find(params[:id])
    @resource.destroy
    flash[:notice] = "Deleted #{@resource.primary_tag} #{@resource.title}"
    redirect_to resources_path(:tags => @resource.primary_tag)
  end

end
