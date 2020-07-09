
require 'rails_helper'

describe GithubService do
  context "instance methods" do
    context '#repo_json' do
      it "returns repo data" do
        json_response = File.read("spec/fixtures/github_user_repos.json")
        stub_request(:get, "https://api.github.com/user/repos").
         with(
           headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Authorization'=>'token 127a71214eb55ed59a8fb9c7b8a1ea75bcd11f19',
          'User-Agent'=>'Faraday v1.0.1'

           }).
         to_return(status: 200, body: json_response, headers: {})
        user = create(:user, token: ENV["GITHUB_TOKEN"])
        service = GithubService.new
        search = service.repo_json(user)
        expect(search).to be_a Array
        expect(search[0]).to have_key "name"
        expect(search[0]).to have_key "url"
      end
    end
    context '#follower_json' do
      it "returns repo data" do


        json_response = File.read("spec/fixtures/github_user_followers.json")

        stub_request(:get, "https://api.github.com/user/followers").
         with(
           headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Authorization'=>'token 127a71214eb55ed59a8fb9c7b8a1ea75bcd11f19',
          'User-Agent'=>'Faraday v1.0.1'

           }).
         to_return(status: 200, body: json_response, headers: {})
        user = create(:user, token: ENV["GITHUB_TOKEN"])
        service = GithubService.new
        search = service.follower_json(user)
        expect(search).to be_a Array
        expect(search[0]).to have_key "login"
        expect(search[0]).to have_key "url"
      end
    end
    context '#following_json' do
      it "returns repo data", :VCR do
        json_response = File.read("spec/fixtures/github_user_following.json")
        stub_request(:get, "https://api.github.com/user/following").
        with(
          headers: {
         'Accept'=>'*/*',
         'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',

         'Authorization'=>'token 127a71214eb55ed59a8fb9c7b8a1ea75bcd11f19',
         'User-Agent'=>'Faraday v1.0.1'
          }).
        to_return(status: 200, body: json_response, headers: {})

        user = create(:user, token: ENV["GITHUB_TOKEN"])
        service = GithubService.new
        search = service.following_json(user)
        expect(search).to be_a Array
        expect(search[0]).to have_key "login"
        expect(search[0]).to have_key "url"
      end
    end
  end
end
