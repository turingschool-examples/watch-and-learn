class GithubService
  def self.connect(current_user)
    Faraday.new(url: 'https://api.github.com',
                params: { access_token: current_user[:token] })
  end
end
