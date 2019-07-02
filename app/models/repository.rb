# frozen_string_literal: true

# This class is for defining the attributes from json repo
class Repository
  attr_reader :name,
              :url
  def initialize(repo)
    @name = repo[:name]
    @url = repo[:html_url]
  end
end
