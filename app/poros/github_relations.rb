class GithubRelations
  attr_reader :handle, :url
  def initialize(user_relations)
    @handle = user_relations[:handle]
    @url = user_relations[:url]
  end
end
