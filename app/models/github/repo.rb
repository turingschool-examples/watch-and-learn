# frozen_string_literal: true

# PORO for repos
class Repo
  attr_reader :name,
              :url

  def initialize(attributes)
    @name = attributes[:name]
    @url = attributes[:html_url]
  end
end
