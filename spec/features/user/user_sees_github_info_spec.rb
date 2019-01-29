require 'rails_helper'

describe 'User Dashboard' do
  context "when logged in with github credentials" do
    before :each do
      json_response = File.open('./spec/fixtures/github_owner_repos.json')
      stub_request(:get, "https://api.github.com/user/repos?affiliation=owner").to_return(status: 200, body: json_response)

      json_response = File.open('./spec/fixtures/github_user_followers.json')
      stub_request(:get, "https://api.github.com/user/followers").to_return(status: 200, body: json_response)

      user = create(:user, github_key: ENV["GITHUB_API_KEY"])
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    end
    it 'has Github section' do
      visit dashboard_path

      within ".github" do
        expect(page).to have_content("Github")
        within ".repositories" do
          expect(page).to have_content("Your Repositories")
          expect(page).to have_css(".repository", count: 5)
        end
      end
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
    it 'links to repos from repo names' do
      json_response = File.read('./spec/fixtures/github_owner_repos.json')
      repos_json = JSON.parse(json_response, symbolize_names: true)[0..4]
      visit dashboard_path

      within ".github" do
        within ".repositories" do
          repos_json.each do |repo|
            expect(page).to have_link("#{repo[:name]}", href: "#{repo[:html_url]}")
          end
        end
      end
    end
    it 'links to follower github profile from follower name' do
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
  end
  context 'when not logged in with user credentials' do
    before :each do
      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      visit dashboard_path
    end
    it 'does not show github section' do
      expect(page).to_not have_css(".github")
      expect(page).to_not have_css(".repositories")
      expect(page).to_not have_css(".repository")
    end
    it 'does not show github followers section' do
      expect(page).to_not have_css(".github")
      expect(page).to_not have_css(".followers")
      expect(page).to_not have_css(".follower")
    end
  end
end
