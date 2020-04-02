class ApplicationMailer < ActionMailer::Base
  default from: 'no_reply@activation.io'
  layout 'mailer'
end
