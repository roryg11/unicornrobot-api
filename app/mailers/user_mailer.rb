class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.password_reset.subject
  #
  def password_reset(user)
    @user = user
    @linkUrl = "localhost:3000/resetPasswordConfirmation/#{user.reset_password_token}"
    mail :to => user.email, :subject => "Password Reset"
  end
end
