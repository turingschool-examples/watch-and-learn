class Repo
  attr_reader :name, :url

  def initialize(data)
    @name = data[:name]
    @url  = data[:url]
  end
end
