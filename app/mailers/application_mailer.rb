# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'no-reply@you_got_mail.io'
  layout 'mailer'
end
