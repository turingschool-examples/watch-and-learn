require 'rails_helper'

describe "User can see Follower and" do
  it "sees a link to add as a friend link next to name" do
    user = create(:user, token: ENV["GITHUB_API_KEY"])
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit "/dashboard"

    within(".github") do
      expect(page).to have_css(".follower")
      within(all(".follower").first) do
        expect(page).to have_content("Add As Friend")
      end
    end
  end
end
