require 'rails_helper'

describe GithubService, :vcr do
  context "instance methods" do
    context "#repos_by_user" do
      it "returns repo data for a user" do
        user = create(:user, token: ENV['GITHUB_TOKEN'])
        search = subject.repos_by_user(user)

        expect(search).to be_an Array
        expect(search.count).to eq 5
        repo_data = search.first

        expect(repo_data).to have_key :name
        expect(repo_data).to have_key :html_url
      end
    end

    context "#followers_by_user" do
      it "returns follower data for a user" do
        user = create(:user, token: ENV['GITHUB_TOKEN'])
        search = subject.followers_by_user(user)

        expect(search).to be_an Array
        expect(search.count).to eq 3
        follower_data = search.first

        expect(follower_data).to have_key :login
        expect(follower_data).to have_key :html_url
      end
    end

    context "#following_by_user" do
      it "returns following data for a user" do
        user = create(:user, token: ENV['GITHUB_TOKEN'])
        search = subject.following_by_user(user)

        expect(search).to be_an Array
        expect(search.count).to eq 1
        following_data = search.first

        expect(following_data).to have_key :login
        expect(following_data).to have_key :html_url
      end
    end

    context "#conn" do
      it "establishes connection to github API" do
        user = create(:user, token: ENV['GITHUB_TOKEN'])
        connection = subject.conn(user)

        expect(connection.class).to eq Faraday::Connection
      end
    end
  end
end
