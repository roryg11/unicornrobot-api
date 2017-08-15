if Rails.env.development?

ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
  address:              'smtp.gmail.com',
  port:                 587,
  domain:               'whenToJump.herokuapp.com',
  user_name:            ENV["GMAIL_USERNAME"],
  password:             ENV["GMAIL_PASSWORD"],
  authentication:       'plain',
  enable_starttls_auto: true
}

elsif Rails.env.production?
  ActionMailer::Base.delivery_method = :smtp
  ActionMailer::Base.smtp_settings = {
    address:              'smtp-relay.sendinblue.com',
    port:                 587,
    domain:               'guarded-thicket-54472.herokuapp.com',
    user_name:            ENV["SENDINBLUE_USERNAME"],
    password:             ENV["SENDINBLUE_PASSWORD"],
    authentication:       'login',
    enable_starttls_auto: true
  }

end
