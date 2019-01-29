require 'rails_helper'

describe 'User Dashboard' do
  context 'when logged in with github credentials' do
    before :each do
      json_response = File.open('./spec/fixtures/github_user_followers.json')
      stub_request(:get, "https://api.github.com/user/followers").to_return(status: 200, body: json_response)

      user = create(:user, github_key: ENV["GITHUB_API_KEY"])
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    end
    it 'has github followers section under github section' do
      visit dashboard_path

      within ".github" do
        expect(page).to have_content("Github")
        within '.followers' do
          expect(page).to have_content("Your Followers")
          expect(page).to have_css(".follower", count: 8)
        end
      end
    end

    it 'each follower name is link to github profile' do
      json_response = File.read('./spec/fixtures/github_user_followers.json')
      followers_json = JSON.parse(json_response, symbolize_names: true)

      visit dashboard_path

      within ".github" do
        within '.followers' do
          followers_json.each do |follower|
            expect(page).to have_link("#{follower[:login]}", href: "#{follower[:html_url]}")
          end
        end
      end
    end

    context 'when not logged in with user credentials' do
      it 'does not show github followers section' do
        user = create(:user)
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
        visit dashboard_path

        expect(page).to_not have_css(".github")
        expect(page).to_not have_css(".followers")
        expect(page).to_not have_css(".follower")
      end
    end
  end
end
