# frozen_string_literal: true

# This class is for defining the attributes from json repo
class Follower
  attr_reader :name,
              :url
              
  def initialize(follower)
    @name = follower[:login]
    @url = follower[:html_url]
  end
end
