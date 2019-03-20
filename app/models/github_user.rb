class GithubUser
  attr_reader :handle

  def initialize(attributes)
    @attributes = attributes
    @handle = attributes[:login]
  end
end
