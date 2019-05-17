# frozen_string_literal: true

# PORO for followers
class Follower
  attr_reader :login,
              :url

  def initialize(attributes)
    @login = attributes[:login]
    @url = attributes[:html_url]
  end
end
