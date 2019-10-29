# frozen_string_literal: true

class Following
  attr_reader :login

  def initialize(attributes = {})
    @login = attributes[:login]
  end
end
