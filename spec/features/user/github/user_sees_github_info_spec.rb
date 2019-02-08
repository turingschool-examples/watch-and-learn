require 'rails_helper'

describe "as a logged in user" do
  describe "on the dashboard" do
    it "shows a list of 5 Github repositories / list of followers / list of followings" do
      user = create(:user, github_token: ENV["GITHUB_API_KEY"])
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      VCR.use_cassette("services/find_repositories") do
        VCR.use_cassette("services/find_followers") do
          VCR.use_cassette("services/find_followings") do
            visit '/dashboard'
          end
        end
      end
      expect(current_path).to eq('/dashboard')
      expect(page).to have_content("Your Github:")
      expect(page).to_not have_link("Connect Your Github")


      expect(page).to have_content("Repositories:")
      expect(page).to have_css(".repo", count: 5)
      within(first(".repo")) do
        expect(page).to have_link()
      end

      expect(page).to have_content("Followers:")
      within(first(".Follower")) do
        expect(page).to have_link()
      end

      expect(page).to have_content("Following:")
      within(first(".Following")) do
        expect(page).to have_link()
      end
    end
  end
end
