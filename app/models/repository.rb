class Repository
  attr_reader :name,
              :full_name

  def initialize(attributes)
    @attributes = attributes
    @name = attributes[:name]
    @full_name = attributes[:full_name]
  end

end
