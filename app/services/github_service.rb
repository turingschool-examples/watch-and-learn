# frozen_string_literal: true

class GithubService

  def initialize(current_user)
    @current_user = current_user
  end

  def github_info
    get_json('/user/repos')
  end

  private

  def get_json(_url)
    response = conn.get(_url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(url: 'https://api.github.com') do |f|
      f.adapter Faraday.default_adapter
      f.authorization :Bearer, "#{@current_user.github_token}"
      #f.params[:key] = current_user.github_key
      # f.token_auth('93b1d005bcfc93c0683486c7b04bbb6872872f73')
    end
  end
end
