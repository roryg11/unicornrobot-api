class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.password_reset.subject
  #
  def password_reset(user)
    @user = user
    @linkUrl = "#{APP_URL}/resetPasswordConfirmation/#{user.reset_password_token}"
    mail :to => user.email, :subject => "Password Reset"
  end

  def confirm_email(user)
    @user = user
    puts @user.confirmation_token
    @linkUrl = "#{APP_URL}/confirm_email/#{@user.confirmation_token}"
    mail :to => @user.email, :subject => "Email Confirmation with When to Jump"
  end
end
