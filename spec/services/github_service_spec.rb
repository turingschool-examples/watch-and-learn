# frozen_string_literal: true

require 'rails_helper'

describe GithubService do
  it "exists" do
    github_servide = GithubService.new

    expect(github_servide).to be_a(GithubService)
  end

  context "#repositories data" do
    it "returns repositories", :vcr do
      search = subject.repository_data
      expect(search).to be_an(Array)
      expect(search[0]).to be_a(Hash)


      member_data = search[0]

      expect(member_data).to have_key(:name)
    end
  end
end
