class HomeController < ApplicationController
  before_filter :authenticate_user!, :only => [:dashboard]
  
  # GET /
  def homepage
    @gallery = Gallery.assigned_to_homepage
    @artwork = @gallery.random_artwork if @gallery
  end
  
  # GET /home
  def dashboard
    @recently_added_artwork = Artwork.order_by(:created_at.desc).limit(6)
  end

  # GET /about
  def about
  end
  
  # GET /contact
  def contact
  end
end
