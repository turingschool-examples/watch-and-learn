# frozen_string_literal: true

class GithubUser
  attr_reader :name,
              :uid,
              :url
  def initialize(data)
    @name = data[:login]
    @url = data[:html_url]
    @uid = data[:id]
  end
end
