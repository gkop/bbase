class ConfigurationController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource(Configuration, :manage)
  
  # GET /edit
  def edit
    @configuration = Configuration.singleton
  end
  
  # PUT /update
  def update
    @configuration = Configuration.singleton
    if @configuration.update_attributes(params[:configuration])
      flash[:notice] = "Successfully updated configuration"
      redirect_back_or_to_root 
    else
      flash[:notice] = "Error updating configuration"
      render :action => "edit"    
    end
  end

end
