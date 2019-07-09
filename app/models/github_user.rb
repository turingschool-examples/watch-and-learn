# frozen_string_literal: true

class GithubUser
  attr_reader :name, :url, :uid
  def initialize(attributes)
    @name = attributes[:login]
    @url = attributes[:html_url]
    @uid = attributes[:id]
  end
end
