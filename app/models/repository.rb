class Repository
  attr_reader :name

  def initialize(attributes)
    @attributes = attributes
    @name = attributes["name"]
  end

end
