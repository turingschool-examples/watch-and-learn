# frozen_string_literal: true

class Github < GithubService
  def initialize(token = 'None')
    super(token)
  end

  def repos
    response = conn.get('/user/repos')
    JSON.parse(response.body, sybomlize_names: true)
  end

  def followers
    response = conn.get('/user/followers')
    JSON.parse(response.body, sybomlize_names: true)
  end

  def following
    response = conn.get('/user/following')
    JSON.parse(response.body, sybomlize_names: true)
  end

  def user_email(handle)
    response = conn_new.get("/users/#{handle}")
    json = JSON.parse(response.body, sybomlize_names: true)
    { email: json['email'], name: json['name'] }
  end
end
