require 'rails_helper'
require 'webmock/rspec'

describe GithubApiService do
  before :each do
    @user = User.create(email: "john@gmail.com", first_name: "John", last_name: "smith", token: "790f5a98275d53160a72ff956ad8a4b171635419")
      @service = GithubApiService.new(@user.token)
      json_repo_response = File.open("./fixtures/user_repos.json")
      stub_request(:get, "https://api.github.com/user/repos").
           with(
             headers: {
         	  'Accept'=>'*/*',
         	  'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
         	  'Authorization'=>'token 790f5a98275d53160a72ff956ad8a4b171635419',
         	  'User-Agent'=>'Faraday v0.15.4'
             }).
           to_return(status: 200, body: json_repo_response, headers: {})

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
end
