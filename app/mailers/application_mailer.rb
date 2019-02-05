class ApplicationMailer < ActionMailer::Base
  default from: 'no_reply@herokuapp.com'
  layout 'mailer'
end
