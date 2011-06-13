class InviteRequestMailer < ActionMailer::Base

  def send_mail(email_address, body)
    subject = "Invite requested for Golahny.org (#{email_address})"

    if body.blank?
      body = "[no note]"
    end
 
    mail(:from => "gabe@golahny.org", :to => "gabe@golahny.org", :subject => subject, :body => body )
  end

end
