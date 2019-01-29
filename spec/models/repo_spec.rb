require 'rails_helper'

RSpec.describe "Repo" do

  it 'exists' do
    response = {"html_url" => "place"}
    repo = Repo.new(response)

    expect(repo).to be_truthy
    expect(repo.class).to eq(Repo)
  end

  it 'has attributes' do
    response = {"html_url" => "place"}
    repo = Repo.new(response)

    expect(repo.url).to eq("place")
  end

  it 'can take git hub api data' do
    conn = Faraday.new(url: "https://api.github.com") do |f|
      f.headers["Authorization"] = "Token #{ENV["DAN_GIT_API_KEY"]}"
      f.adapter Faraday.default_adapter
    end

    response = conn.get "/user/repos"

    littleshop = JSON.parse(response.body).first

    littleshop_repo = Repo.new(littleshop)

    expect(littleshop_repo.url).to eq(littleshop["html_url"])

  end

end
