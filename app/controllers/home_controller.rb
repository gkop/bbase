class HomeController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource(User)
  
  # GET /home
  def index
  end
end
