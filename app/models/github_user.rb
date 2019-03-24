class GithubUser
attr_reader :handle,
            :url,
            :uid
  def initialize(attributes)
    @handle = attributes[:login]
    @url = attributes[:html_url]
    @uid = attributes[:id]
  end
end
