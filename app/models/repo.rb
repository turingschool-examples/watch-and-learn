class Repo 

  attr_reader :name,
              :url

  def initialize(repo_data)
    # require 'pry'; binding.pry
    @name = repo_data[:name]
    @url = repo_data[:html_url]
  end
  
end 