# frozen_string_literal: true

# PORO for following
class Following
  attr_reader :login,
              :url

  def initialize(attributes)
    @login = attributes[:login]
    @url = attributes[:html_url]
  end
end
