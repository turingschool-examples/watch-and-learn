require 'rails_helper'

describe "as a logged in user" do
  describe "on the dashboard" do
    it "shows a list of 5 Github repositories" do
      user = create(:user, github_token: ENV["GITHUB_API_KEY"])
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      VCR.use_cassette("services/find_co_members") do
        visit '/dashboard'
      end

      expect(page).to have_content("Your Github Repositories:")
      expect(current_path).to eq('/dashboard')
      expect(page).to have_css(".repo", count: 5)
      within(first(".repo")) do
        expect(page).to have_link()
      end
    end
  end
end
