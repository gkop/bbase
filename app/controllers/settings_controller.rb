class SettingsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource(Settings, :manage)
  
  # GET /edit
  def edit
    @settings = Settings.singleton
  end
  
  # PUT /update
  def update
    @settings = Settings.singleton
    if @settings.update_attributes(params[:settings])
      flash[:notice] = "Successfully updated settings"
      redirect_back_or_to_root 
    else
      flash[:notice] = "Error updating settings"
      render :action => "edit"    
    end
  end

end
