require 'rails_helper'

describe Repo, type: :model do
  it "exists" do
    repo = Repo.new({})
    expect(repo).to be_a(Repo)
  end

  it "has attributes" do
    json = File.read('./spec/fixtures/github_owner_repos.json')
    json_hash = JSON.parse(json, symbolize_names: true)
    repo = Repo.new(json_hash.first)

    expect(repo.name).to eq(json_hash.first[:name])
    expect(repo.full_name).to eq(json_hash.first[:full_name])
    expect(repo.html_url).to eq(json_hash.first[:html_url])
    expect(repo.description).to eq(json_hash.first[:description])
  end
end
