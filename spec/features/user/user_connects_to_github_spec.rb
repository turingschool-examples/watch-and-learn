require 'rails_helper'

describe 'As a user' do
  describe 'When I visit /dashboard' do
    describe 'Then I should see a link that is styled like a button that says "Connect to Github"' do
      it 'should see all of the content from the previous Github stories (repos, followers, and following)' do
        user = create(:user)
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
        Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:github]
        repo_response = File.open("./fixtures/github_repos.json")
        stub_request(:get, "https://api.github.com/user/repos?sort=updated_at&access_token=#{ENV['GITHUB_TEST_TOKEN']}").
          to_return(status: 200, body: repo_response)
        follower_response = File.open("./fixtures/github_followers.json")
        stub_request(:get, "https://api.github.com/user/followers?access_token=#{ENV['GITHUB_TEST_TOKEN']}").
          to_return(status: 200, body: follower_response)
        following_response = File.open("./fixtures/github_following.json")
        stub_request(:get, "https://api.github.com/user/following?access_token=#{ENV['GITHUB_TEST_TOKEN']}").
          to_return(status: 200, body: following_response)

        visit dashboard_path

        expect(page).to have_button('Connect to Github')
        click_button 'Connect to Github'

        expect(current_path).to eq(dashboard_path)
        save_and_open_page
        expect(page).to have_css('.github')
        expect(page).to have_css('.followers')
        expect(page).to have_css('.following')

        within ".github" do
          expect(page).to have_content("Github")
          expect(page).to have_link("brownfield-of-dreams")
          expect(page).to have_link("rales_engine")
          expect(page).to have_link("jungle_beats")
          expect(page).to have_link("here-be-dragons")
          expect(page).to have_link("monster_shop")
        end

        within ".followers" do
          expect(page).to have_link('renecasco')
        end

        within ".following" do
          expect(page).to have_link('cebarks')
        end
      end
    end
  end
end
