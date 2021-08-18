class UserMailer < ApplicationMailer
  default from: 'example@example.com'

  def welcome_email
    @user = params[:user]
    @url  = new_user_session_url
    mail(to: @user.email, subject: 'Welcome to Example')
  end
end
