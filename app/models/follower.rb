require_relative "./concerns/registered_helper"

class Follower
  include RegisteredHelper

  attr_reader :login, :html_url

  def initialize(follower_data)
    @login = follower_data[:login]
    @html_url = follower_data[:html_url]
  end

end
