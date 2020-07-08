class ApplicationMailer < ActionMailer::Base
  default from: 'brownfield@secure-fjord.com'
  layout 'mailer'
  default_url_options[:host] = 'https://secure-fjord-62840.herokuapp.com/'
end
