require "rails_helper"

RSpec.describe 'User' do

    it 'Can see github with 5 repositories' do
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

      user = create(:user, token: ENV["GITHUB_TOKEN"])
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit(dashboard_path)
      expect(page).to have_css('.github')

    end


  it 'Can see secton for github and see all followers with there handles being links' do

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


    user = create(:user, token: ENV["GITHUB_TOKEN"])
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit(dashboard_path)
    expect(page).to have_css('.github')
    expect(page).to have_css('.followers')


  end
  it 'Can see secton for github and see all followers with there handles being links' do
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
          
    user = create(:user, token: ENV["GITHUB_TOKEN"])
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit(dashboard_path)
    expect(page).to have_css('.github')
    expect(page).to have_css('.followers')
    expect(page).to have_css('.following')


  end
end
