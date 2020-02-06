require 'rails_helper'

describe "As a user can see github repos" do
  it "on their dashboard", :vcr do
  token = ENV["GITHUB_TOKEN_LOCAL"]

  user = create(:user, token: token)

  allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
  #
  # response = File.read('spec/fixtures/user_github_repos.json')
  # stub_request(:get, "https://api.github.com/user/repos?access_token=#{user.token}").
  # to_return(status: 200, body: response)
  # response_hash = JSON.parse(response, symbolize_names: true)
  #
  # repos = response_hash.map do |data|
  #   Repo.new(data)
  # end
  # repos.sample(5)
    visit dashboard_path

    expect(current_path).to eq(dashboard_path)

  end
end
