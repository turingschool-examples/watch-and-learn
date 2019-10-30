# frozen_string_literal: true

require 'rails_helper'

describe GithubService do
  subject = described_class.new(ENV['GITHUB_TOKEN_TEST'])

  it "exists" do
    expect(subject).to be_a(described_class)
  end

  it "returns repositories" do
    repos_json = File.open("./fixtures/repositories.json")
    stub_request(:get, 'https://api.github.com/user/repos').
      to_return(status: 200, body: repos_json)
    search = subject.repository_data
    expect(search).to be_an(Array)
    expect(search[0]).to be_a(Hash)

    repository_data = search[0]

    expect(repository_data).to have_key(:name)
  end

  it "returns followers" do
    followers_json = File.open("./fixtures/followers.json")
    stub_request(:get, 'https://api.github.com/user/followers').
      to_return(status: 200, body: followers_json)

    search = subject.follower_data
    expect(search).to be_an(Array)
    expect(search[0]).to be_a(Hash)

    follower_data = search[0]

    expect(follower_data).to have_key(:login)
  end

  it "returns following", :vcr do
    following_json = File.open("./fixtures/following.json")
    stub_request(:get, 'https://api.github.com/user/following').
      to_return(status: 200, body: following_json)

    search = subject.follower_data
    expect(search).to be_an(Array)
    expect(search[0]).to be_a(Hash)

    following_data = search[0]

    expect(following_data).to have_key(:login)
  end
end
