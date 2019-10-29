# frozen_string_literal: true

class Follower
  attr_reader :login
  def initialize(attributes = {})
    @name = attributes[:login]
  end
end
