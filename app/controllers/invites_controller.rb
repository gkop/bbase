class InvitesController < ApplicationController
  
  # GET /users/sign_up(.:format)
  def new
  end

  # POST /invites/create
  def create
    InviteRequestMailer.send_mail(params[:email], params[:note]).deliver
  end
end
