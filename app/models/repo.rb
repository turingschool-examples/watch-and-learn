class Repo
  attr_reader :name,
              :url

  def initialize(repo_data)
    binding.pry
    @name = repo_data[:name]
    @url = repo_data[:url]
  end
end
