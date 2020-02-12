class Following
  attr_reader :name, :url, :u_id
  def initialize(data)
    @name = data[:login]
    @url = data[:html_url]
    @u_id = data[:id]
  end
end
