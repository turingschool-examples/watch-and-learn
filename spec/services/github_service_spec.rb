require 'rails_helper'

describe GithubService do
  it "exists" do
    github_service = GithubService.new

    expect(github_service).to be_a(GithubService)
  end

  context "instance methods" do
    context "#repository_data" do
      it "returns repositories", :vcr do
        search = subject.repository_data
        expect(search).to be_a Array
        expect(search.count).to eq 30
        expect(search[0]).to be_an Hash
        member_data = search[0]

        expect(member_data).to have_key :name
      end
    end
  end
end
