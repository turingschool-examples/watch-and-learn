require 'rails_helper'

describe "As a user" do
  it "can see github repos on dashboard" do
  user = create(:user, token: ENV['GITHUB_TOKEN_LOCAL'])
  allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

  response = File.read('spec/fixtures/user_github_repos.json')
  stub_request(:get, "https://api.github.com/user/repos?access_token=0fe02a19242b3e280653bfc5fd3e1ecb567966ba").
  to_return(status: 200, body: response)
  response_hash = JSON.parse(response, symbolize_names: true)
  repos = response_hash.map do |data|
    Repo.new(data)
  end

    visit dashboard_path

    expect(current_path).to eq(dashboard_path)

    repos.each do |repo|
      within "#repo-#{repo.name}" do
        expect(page).to have_link(repo.name)
      end
    end
  end
end
