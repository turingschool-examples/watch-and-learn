require 'rails_helper'

describe 'A registered user' do
  it "can see a github section with 5 repos" do
    conn = Faraday.new("https://api.github.com") do |req|
      req.headers["Authorization"] = "token #{ENV["GITHUB_TOKEN"]}"
    end

    repos = conn.get("/user/repos")
    parsed_repos = JSON.parse(repos.body, symbolize_names: true)
    require "pry"; binding.pry
  end
end
