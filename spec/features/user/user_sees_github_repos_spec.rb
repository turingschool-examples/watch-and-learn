require 'rails_helper'

describe 'User Dashboard' do
  context "when logged in with github credentials" do
    before :each do
      json_response = File.open('./spec/fixtures/github_owner_repos.json')
      stub_request(:get, "https://api.github.com/user/repos?affiliation=owner").to_return(status: 200, body: json_response)

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
  end
  context 'when not logged in with user credentials' do
    it 'does not show github section' do
      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      visit dashboard_path

      expect(page).to_not have_css(".github")
      expect(page).to_not have_css(".repositories")
      expect(page).to_not have_css(".repository")
    end
  end
end
