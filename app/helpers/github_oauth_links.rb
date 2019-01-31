module GithubOauthLinks
  AUTHORIZE = "https://github.com/login/oauth/authorize?client_id=#{ENV["LOCAL_CLIENT_ID"]}&scope=repo"
  def self.req_access_token(code)
    "https://github.com/login/oauth/access_token?client_id=#{ENV["LOCAL_CLIENT_ID"]}&client_secret=#{ENV["LOCAL_CLIENT_SECRET"]}&code=#{code}"
  end
end
