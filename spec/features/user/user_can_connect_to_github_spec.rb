require "rails_helper"

RSpec.describe "As a user", type: :feature do
  it "Can connect to githbub" do

    json_response_repos = File.read("spec/fixtures/github_user_repos.json")
    stub_request(:get, "https://api.github.com/user/repos").
        with(
          headers: {
         'Accept'=>'*/*',
         'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
         'Authorization'=>'token 127a71214eb55ed59a8fb9c7b8a1ea75bcd11f19',
         'User-Agent'=>'Faraday v1.0.1'
          }).
        to_return(status: 200, body: json_response_repos, headers: {})

    json_response_followers = File.read("spec/fixtures/github_user_followers.json")
    stub_request(:get, "https://api.github.com/user/followers").
        with(
          headers: {
         'Accept'=>'*/*',
         'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
         'Authorization'=>'token 127a71214eb55ed59a8fb9c7b8a1ea75bcd11f19',
         'User-Agent'=>'Faraday v1.0.1'
          }).
        to_return(status: 200, body: json_response_followers, headers: {})

    json_response_following = File.read("spec/fixtures/github_user_following.json")
    stub_request(:get, "https://api.github.com/user/following").
     with(
       headers: {
      'Accept'=>'*/*',
      'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
      'Authorization'=>'token 127a71214eb55ed59a8fb9c7b8a1ea75bcd11f19',
      'User-Agent'=>'Faraday v1.0.1'
       }).
     to_return(status: 200, body: json_response_following, headers: {})


    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new({"provider"=>"github",
          "uid"=>"60331187",
          "info"=> {"nickname"=>"EricLarson2020",
                    "email"=>"ericlarsonbroom@gmail.com",
                    "name"=>"Eric Larson",
                    "image"=>"https://avatars1.githubusercontent.com/u/60331187?v=4",
                    "urls"=>{"GitHub"=>"https://github.com/EricLarson2020", "Blog"=>""}},
          "credentials"=>{"token"=>"a3b3d35acaff0e69c06b431dfadb71ee9d675f8a", "expires"=>false}})

      user = create(:user)

    visit '/'
    click_on "Sign In"

    expect(current_path).to eq(login_path)

    fill_in 'session[email]', with: user.email
    fill_in 'session[password]', with: user.password

    click_on 'Log In'

    expect(current_path).to eql("/dashboard")

      json_response_repos = File.read("spec/fixtures/github_user_repos.json")
       stub_request(:get, "https://api.github.com/user/repos").
         with(
           headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Authorization'=>'token a3b3d35acaff0e69c06b431dfadb71ee9d675f8a',
          'User-Agent'=>'Faraday v1.0.1'
           }).
         to_return(status: 200, body: json_response_repos, headers: {})

         json_response_followers = File.read("spec/fixtures/github_user_followers.json")
         stub_request(:get, "https://api.github.com/user/followers").
                 with(
                   headers: {
                  'Accept'=>'*/*',
                  'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
                  'Authorization'=>'token a3b3d35acaff0e69c06b431dfadb71ee9d675f8a',
                  'User-Agent'=>'Faraday v1.0.1'
                   }).
                 to_return(status: 200, body: json_response_followers, headers: {})

json_response_following = File.read("spec/fixtures/github_user_following.json")
       stub_request(:get, "https://api.github.com/user/following").
      with(
        headers: {
       'Accept'=>'*/*',
       'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
       'Authorization'=>'token a3b3d35acaff0e69c06b431dfadb71ee9d675f8a',
       'User-Agent'=>'Faraday v1.0.1'
        }).

      to_return(status: 200, body: json_response_following, headers: {})


    click_on "Connect to Github"




      expect(current_path).to eql("/dashboard")
      expect(page).to have_content("Connected to Github")
    end
  end
