# frozen_string_literal: true

require 'rails_helper'

describe GithubService do
  it "exists" do
    github_servide = described_class.new

    expect(github_servide).to be_a(described_class)
  end

  it "returns repositories", :vcr do
    search = subject.repository_data
    expect(search).to be_an(Array)
    expect(search[0]).to be_a(Hash)

    repository_data = search[0]

    expect(repository_data).to have_key(:name)
  end

  it "returns followers", :vcr do
    search = subject.follower_data
    expect(search).to be_an(Array)
    expect(search[0]).to be_a(Hash)

    follower_data = search[0]

    expect(follower_data).to have_key(:login)
  end
end
