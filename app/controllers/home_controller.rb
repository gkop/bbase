class HomeController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource(User)
  
  # GET /home
  def index
    @recently_added_artwork = Artwork.order_by(:created_at.desc).limit(6)
  end
end
