# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'no_reply@brownfield.com'
  layout 'mailer'
end
