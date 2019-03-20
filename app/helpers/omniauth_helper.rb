module OmniauthHelper
  def stub_github
    OmniAuth.config.test_mode = true

    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new({
      provider: 'github',
      uid: "1234",
      credentials: {
        token: 'github_token_goes_here'
      }
      })
  end
end
