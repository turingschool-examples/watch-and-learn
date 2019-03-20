class GithubUser

  attr_reader :name,
              :address

  def initialize(attributes)
    @name = attributes[:login]
    @address = attributes[:html_url]

  end
end
