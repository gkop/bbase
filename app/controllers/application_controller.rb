class ApplicationController < ActionController::Base
  protect_from_forgery

  def redirect_back_or_to_root
    redirect_to request.referer || root_path
  end

end
