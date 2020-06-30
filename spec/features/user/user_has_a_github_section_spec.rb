require 'rails_helper'

describe 'A registered user' do
  it "can see a github section with 5 repos" do
    user = create(:user, token: ENV["GITHUB_TOKEN"])
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit(dashboard_path)
    expect(page).to have_css('.github')
  end
end

# conn = Faraday.new("https://api.github.com") do |req|
#   req.headers["Authorization"] = "token #{ENV["GITHUB_TOKEN"]}"
# end
#
# repos = conn.get("/user/repos")
# parsed_repos = JSON.parse(repos.body, symbolize_names: true)
# require "pry"; binding.pry
