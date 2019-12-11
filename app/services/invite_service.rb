class InviteService
  def initialize(token, path)
    @token = token
    @path = path
  end

  def retrieve_invitee
    invitee = retrieve_json
    {
      name: invitee[:name],
      email: invitee[:email]
    }
  end

  private

  def connection
    Faraday.new('https://api.github.com/users') do |faraday|
      faraday.params['access_token'] = @token
      faraday.adapter Faraday.default_adapter
    end
  end

  def retrieve_json
    response = connection.get(@path)
    JSON.parse(response.body, symbolize_names: true)
  end
end
