require 'rails_helper'

describe 'Github Oauth' do
  context 'on user dashboard' do
    it "shows button to connect account" do
      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit dashboard_path
      expect(page).to have_link("Connect to Github")
    end
    context "when clicking 'Connect to Github'" do
      before :each do
        user = create(:user)
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

        json_response = File.open('./spec/fixtures/github_owner_repos.json')
        stub_request(:get, "https://api.github.com/user/repos?affiliation=owner").to_return(status: 200, body: json_response)

        json_response = File.open('./spec/fixtures/github_user_followers.json')
        stub_request(:get, "https://api.github.com/user/followers").to_return(status: 200, body: json_response)

        json_response = File.open('./spec/fixtures/github_user_following.json')
        stub_request(:get, "https://api.github.com/user/following").to_return(status: 200, body: json_response)

        stub_omniauth
        Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:github]

        visit dashboard_path
        click_link "Connect to Github"
      end
      it 'redirects back to dashboard and shows content from Github profile' do
        expect(current_path).to eq(dashboard_path)

        json_response = File.read('./spec/fixtures/github_owner_repos.json')
        repos_json = JSON.parse(json_response, symbolize_names: true)[0..4]

        json_response = File.read('./spec/fixtures/github_user_followers.json')
        followers_json = JSON.parse(json_response, symbolize_names: true)

        json_response = File.read('./spec/fixtures/github_user_following.json')
        following_json = JSON.parse(json_response, symbolize_names: true)

        within ".github" do
          within ".repositories" do
            repos_json.each do |repo|
              expect(page).to have_link("#{repo[:name]}", href: "#{repo[:html_url]}")
            end
          end
          within '.followers' do
            followers_json.each do |follower|
              expect(page).to have_link("#{follower[:login]}", href: "#{follower[:html_url]}")
            end
          end
          within '.following' do
            following_json.each do |user|
              expect(page).to have_link("#{user[:login]}", href: "#{user[:html_url]}")
            end
          end
        end
      end
      def stub_omniauth
        OmniAuth.config.test_mode = true
        OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new({
          provider: 'github',
          credentials: {
            token: ENV["GITHUB_API_KEY"]
          }
        })
      end
    end
  end
end
