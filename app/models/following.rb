# frozen_string_literal: true

# This class is for defining the attributes from json repo
class Following
  attr_reader :name,
              :url

  def initialize(following)
    @name = following[:login]
    @url = following[:html_url]
  end
end
