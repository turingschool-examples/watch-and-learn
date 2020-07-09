require "rails_helper"

RSpec.describe 'User' do

    it 'It can send an email invite to a github user' do
      user_1 = User.create(
        email: "user_1@email.com",
        first_name: "Eric",
        last_name: "bobby",
        password: "password",
        role: 0,
        token: ENV['GITHUB_TOKEN']
      )



  allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)

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

   json_self = File.read("spec/fixtures/github_self_info.json")
   stub_request(:get, "https://api.github.com/users/EricLarson2020").
       with(
         headers: {
        'Accept'=>'*/*',
        'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
        'Authorization'=>'token 127a71214eb55ed59a8fb9c7b8a1ea75bcd11f19',
        'User-Agent'=>'Faraday v1.0.1'
         }).
       to_return(status: 200, body: json_self, headers: {})

       json_self = File.read("spec/fixtures/github_self_info.json")
       stub_request(:get, "https://api.github.com/user").
           with(
             headers: {
            'Accept'=>'*/*',
            'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'Authorization'=>'token 127a71214eb55ed59a8fb9c7b8a1ea75bcd11f19',
            'User-Agent'=>'Faraday v1.0.1'
             }).
           to_return(status: 200, body: json_self, headers: {})

  visit "/dashboard"

  click_on "Send an Invite"

  expect(current_path).to eql('/invite')

  fill_in :github_handle, with: 'EricLarson2020'
  click_on "Send Invite"



expect(current_path).to eq('/dashboard')
expect(page).to have_content('Successfully sent invite!')
  end
end
