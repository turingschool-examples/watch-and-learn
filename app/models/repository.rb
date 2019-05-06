class Repository
attr_reader :name, :url

  def initialize(data)
    @name = data[:name]
    @url = data[:svn_url]
  end
end
