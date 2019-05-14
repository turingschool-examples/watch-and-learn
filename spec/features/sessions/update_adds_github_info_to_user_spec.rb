require 'rails_helper'

context 'as a logged-in user that has enabled github' do
  describe 'when I connect with github' do
    before(:each) do
      OmniAuth.config.mock_auth[:github] = nil
      OmniAuth.config.test_mode = true
      OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new({"provider"=>"github",
       "uid"=>"45905026",
       "info"=>
        {"name"=>"Jalena Taylor"},
       "credentials"=>{"token"=>ENV["TEST_GITHUB_TOKEN"], "expires"=>false},
       "extra"=>
        {"raw_info"=>
          {"login"=>"jalena-penaligon",
           "id"=>45905026,
           "html_url"=>"https://github.com/jalena-penaligon",
           "name"=>"Jalena Taylor",
           }}})
    end

    it 'should successfully update the user', :vcr do
      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit dashboard_path

      expect(page).to_not have_css(".github-followers")
      expect(page).to_not have_css(".github-followings")
      expect(page).to_not have_css('.github-repos')

      click_link "Connect to Github"
      expect(page).to have_css(".github-followers")
      expect(page).to have_css(".github-followings")
      expect(page).to have_css('.github-repos')
      expect(current_path).to eq(dashboard_path)

      expect(user.access_token).to eq(ENV["TEST_GITHUB_TOKEN"])
      expect(user.github_login).to eq("jalena-penaligon")
    end
  end
end
