module GithubOauthLinks
  AUTHORIZE = "https://github.com/login/oauth/authorize?client_id=#{ENV["CLIENT_ID"]}&scope=repo"
end
