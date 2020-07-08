require 'rails_helper'

describe 'As a registered user' do
  describe 'When I visit the dashboard' do
    it 'I see a list of who i follow on github', :vcr do
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
      # within('#github-following') do
      #   expect(page).to have_css(".following-handle", count: 3)
      # end
    end

    it 'has a link to the github following handles' do
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
        expect(page).to have_link("stcho", :href => "https://github.com/stcho")
    end

    it 'Does not display a github following section if the user does not have a token' do
      user = create(:user)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit '/dashboard'

      expect(page).to_not have_css('.following-handle')
    end

    it 'Shows correct following when there is more than one user with different github tokens' do
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

      within('#github-following') do
        expect(page).to have_content("HughBerriez")
        expect(page).to have_content("rickbacci")
        expect(page).to have_content("stcho")
      end
    end
  end

end
