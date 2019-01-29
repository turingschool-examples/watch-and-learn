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

  it 'can take users git hub api token' do
    VCR.use_cassette("all the things") do
      user = create(:user, token: ENV["DAN_GIT_API_KEY"])
      conn = Faraday.new(url: "https://api.github.com") do |f|
        f.headers["Authorization"] = "Token #{user.token}"
        f.adapter Faraday.default_adapter
      end

      response = conn.get "/user/repos"

      littleshop = JSON.parse(response.body).first

      littleshop_repo = Repo.new(littleshop)

      expect(littleshop_repo.url).to eq(littleshop["html_url"])
    end
  end

  it 'can generate repos from api response' do
    VCR.use_cassette("all the things") do
      user = create(:user, token: ENV["DAN_GIT_API_KEY"])
      conn = Faraday.new(url: "https://api.github.com") do |f|
        f.headers["Authorization"] = "Token #{user.token}"
        f.adapter Faraday.default_adapter
      end

      response = conn.get "/user/repos"

      actual = JSON.parse(response.body).first["html_url"]


      repos = Repo.generate(response)
      expected = repos.first.url

      expect(expected).to eq(actual)
    end
  end

end
