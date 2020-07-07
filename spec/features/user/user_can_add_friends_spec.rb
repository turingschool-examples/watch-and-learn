require 'rails_helper'

  feature 'A user can follow another user' do
    scenario 'if both are in the database and they are in the github following' do

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


      user_1 = User.create(
        email: "user_1@email.com",
        first_name: "Eric",
        last_name: "bobby",
        password: "password",
        role: 0,
        token: ENV['GITHUB_TOKEN']
      )

      user_2 = User.create(
        email: "user_2@email.com",
        first_name: "Stella",
        last_name: "Jimster",
        password: "password",
        role: 0,
        uid: 55362003
      )

      user_3 = User.create(
        email: "user_3@email.com",
        first_name: "Max",
        last_name: "Christer",
        password: "password",
        role: 0,
        uid: 57552462
      )


      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)
      visit "/dashboard"
      save_and_open_page

      within ('.followers') do
        expect(page).to have_content("Befriend Max")
        expect(page).to have_content("Befriend Stella")
      end

      within ('.following') do
        expect(page).to have_content("Befriend Max")
        expect(page).to_not have_content("Befriend Stella")
      end
    end
  end
