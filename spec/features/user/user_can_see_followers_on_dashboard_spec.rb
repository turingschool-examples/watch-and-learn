require 'rails_helper'

feature 'When I visit the dashboard' do
  scenario "it shows followers", :vcr do
      user = create(:user, token:  ENV["GITHUB_API_TOKEN_R"])

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      json_response = File.read('spec/fixtures/github_user_repos.json')
      stub_request(:get, "https://api.github.com/user/repos").
           with(
             headers: {
         	  'Accept'=>'*/*',
         	  'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
         	  'Authorization'=> "token #{ENV['GITHUB_API_TOKEN_R']}",
         	  'User-Agent'=>'Faraday v1.0.1'
             }).
           to_return(status: 200, body: json_response, headers: {})
      visit '/dashboard'
      within('#github-followers') do
        expect(page).to have_content("HughBerriez")
        expect(page).to have_content("rickbacci")
      end
    end

  scenario "has a link to the github followers handles", :vcr do
    user = create(:user, token:  ENV["GITHUB_API_TOKEN_R"])

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    json_response = File.read('spec/fixtures/github_user_repos.json')
    stub_request(:get, "https://api.github.com/user/repos").
         with(
           headers: {
       	  'Accept'=>'*/*',
       	  'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
       	  'Authorization'=> "token #{ENV['GITHUB_API_TOKEN_R']}",
       	  'User-Agent'=>'Faraday v1.0.1'
           }).
         to_return(status: 200, body: json_response, headers: {})
    visit '/dashboard'

      expect(page).to have_link("HughBerriez", :href => "https://github.com/HughBerriez")
      expect(page).to have_link("rickbacci", :href => "https://github.com/rickbacci")
  end

  scenario 'Does not display a github followers section if the user does not have a token', :vcr do
    user = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    json_response = File.read('spec/fixtures/github_user_repos.json')
    stub_request(:get, "https://api.github.com/user/repos").
         with(
           headers: {
       	  'Accept'=>'*/*',
       	  'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
       	  'Authorization'=> "token #{ENV['GITHUB_API_TOKEN_R']}",
       	  'User-Agent'=>'Faraday v1.0.1'
           }).
         to_return(status: 200, body: json_response, headers: {})
    visit '/dashboard'

    expect(page).to_not have_css(".github_followers")
  end

  scenario 'Shows correct followers when there is more than one user with different github tokens', :vcr do
    user = create(:user, token:  ENV["GITHUB_API_TOKEN"])
    rostam = create(:user, token:  ENV["GITHUB_API_TOKEN_R"])

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(rostam)
    json_response = File.read('spec/fixtures/github_user_repos.json')
    stub_request(:get, "https://api.github.com/user/repos").
         with(
           headers: {
       	  'Accept'=>'*/*',
       	  'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
       	  'Authorization'=> "token #{ENV['GITHUB_API_TOKEN_R']}",
       	  'User-Agent'=>'Faraday v1.0.1'
           }).
         to_return(status: 200, body: json_response, headers: {})
    visit '/dashboard'

    within('#github-followers') do
      expect(page).to have_content("HughBerriez")
      expect(page).to have_content("rickbacci")
    end
  end
end
