require 'rails_helper'

describe 'As a registered user' do
  describe 'When I visit my dashboard and I am connected to github' do
    describe 'If anybody in my followers/following list have an account' do
      it "I can add them as a friend" do
        user_1 = create(:user)
        user_2 = create(:user)
        user_2.tokens.create(username: "renecasco", uid: "9238673987", token: "29348729387908723", provider: "github")
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

        visit login_path

        fill_in 'Email', with: user_1.email
        fill_in 'Password', with: user_1.password

        click_button 'Log In'

        click_button 'Connect to Github'

        within "#fr-renecasco" do
          expect(page).to have_button 'Add Friend'
          click_button 'Add Friend'
        end

        expect(current_path).to eq dashboard_path

        expect(page).to have_content("Friend has been added.")

        expect(page).to have_css(".friends")

        within ".friends" do
          expect(page).to have_content(user_2.first_name)
        end

        within "#fr-renecasco" do
          expect(page).to_not have_button 'Add Friend'
        end
      end
    end
  end
end
