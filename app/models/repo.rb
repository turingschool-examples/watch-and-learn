# frozen_string_literal: true

class Repo
  attr_reader :name, :link
  def initialize(repo_info)
    @name = repo_info[:name]
    @link = repo_info[:html_url]
  end
end
