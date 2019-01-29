require 'rails_helper'

describe "As a logged in user" do
  before(:each) do
    user = create(:user, github_token: ENV["GITHUB_ACCESS_TOKEN"])
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
  end

  describe "When I visit /dashboard" do
    it "I should see a 'Github' section with a list of 5 followers" do
      visit dashboard_path

      within("section#followers") do
        expect(page).to have_css(".repository", count: 5)
        expect(page).to have_css(".repo-link", count: 5)
      end
    end
  end
end
