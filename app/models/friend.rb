# frozen_string_literal: true

class Friend
  attr_reader :login, :url

  def initialize(data)
    @login, @url = data(data)
  end

  def set_data(data)
    friend = data.friend.user_credentails.find_by(website: "github")
    [friend.nickname, friend.url]
  end
end
