Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV['GOOGLE_CLIENT_ID'], ENV['GOOGLE_CLIENT_SECRET']
end

# Rails.application.config.middleware.use OmniAuth::Builder do
#   provider :github, ENV['GITHUB_API_TOKEN_R'], ENV['CLIENT_API_KEY']
# end
