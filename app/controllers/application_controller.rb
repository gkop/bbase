class ApplicationController < ActionController::Base
  protect_from_forgery

  def redirect_back_or_to_root
    redirect_to request.referer || root_path
  end

  rescue_from CanCan::AccessDenied do
    if current_user
      raise
    else 
      redirect_to new_user_session_path, :notice => "You must be logged in to do that"
    end
  end

end
