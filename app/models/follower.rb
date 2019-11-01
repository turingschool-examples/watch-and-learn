# frozen_string_literal: true

class Follower
  attr_reader :login, :url, :user_id
  def initialize(attributes = {})
    @login = attributes[:login]
    @url = attributes[:html_url]
    @user_id = find_user_id
  end

  def find_user_id
    name = UserCredential.where(nickname: @login)
    name.empty? ? nil : name[0]["user_id"]
  end
end
