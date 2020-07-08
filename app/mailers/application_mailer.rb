class ApplicationMailer < ActionMailer::Base
  default from: 'secure-fjord@brownfield.com'
  layout 'mailer'
  default_url_options[:host] = 'https://secure-fjord-62840.herokuapp.com/'
end
