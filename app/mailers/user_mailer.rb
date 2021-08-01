class UserMailer < ApplicationMailer
  default from: 'info@deskforaday.com'

  def welcome_email
    @user = params[:user]
    @url  = new_user_session_url
    mail(to: @user.email, subject: 'Welcome to DeskForADay')
  end
end
