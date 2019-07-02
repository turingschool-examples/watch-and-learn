require 'rails_helper'
require 'webmock/rspec'

describe GithubApiService do
  before :each do
    @user = User.create(email: "john@gmail.com", first_name: "John", last_name: "smith", token: ENV['GITHUB_API_KEY'])

      @service = GithubApiService.new(@user.token)

      json_repo_response = File.open("./fixtures/user_repos.json")
      stub_request(:get, "https://api.github.com/user/repos").
           with(
             headers: {
         	  'Accept'=>'*/*',
         	  'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
         	  'User-Agent'=>'Faraday v0.15.4'
             }).
           to_return(status: 200, body: json_repo_response, headers: {})

      json_following_response = File.open("./fixtures/user_following.json")
      stub_request(:get, "https://api.github.com/user/following").
           with(
             headers: {
         	  'Accept'=>'*/*',
         	  'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
         	  'User-Agent'=>'Faraday v0.15.4'
             }).
           to_return(status: 200, body: json_following_response, headers: {})

    end

    it "exists" do
      expect(@service.class).to eq(GithubApiService)
    end

  context "#repos" do
    it "returns a given number of github repositories with token" do
      repo_data = @service.repos[0]
      expect(repo_data).to be_a Hash
      expect(repo_data).to have_key :name
      expect(repo_data).to have_key :html_url
    end
  end

  context "#following" do
    it "returns a given number of github users, current user is following" do
      following = @service.following[0]

      expect(following).to be_a Hash
      expect(following).to have_key :login
      expect(following).to have_key :html_url
    end
  end
  
  context "#followers" do
    it "returns all github follower handles, and links to their github accounts" do
      follower_data = @service.followers[0]

      expect(follower_data).to be_a Hash
      expect(follower_data).to have_key :login
      expect(follower_data).to have_key :html_url
    end
  end
end
