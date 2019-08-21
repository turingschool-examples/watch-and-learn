class Repo
  attr_reader :full_path, :path

  def initialize(data)
    @full_path = data[:html_url]
    @path = data[:name]
  end
end
