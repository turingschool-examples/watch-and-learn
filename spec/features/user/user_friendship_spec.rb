require 'rails_helper'

describe "User can see Follower and" do
  it "sees a link to add as a friend link next to name" do
    user = create(:user, token: ENV["GITHUB_API_KEY"])
    user_2 = create(:user, github_username: ENV["FRIEND_1"])
    user_3 = create(:user, github_username: ENV["FRIEND_2"])
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit "/dashboard"

    within(".github") do
      expect(page).to have_css(".follower")
      within(all(".follower").first) do
        expect(page).to have_content("Add as Friend")
        click_on "Add as Friend"
      end
      within(all(".follower")[1]) do
        expect(page).to have_no_content("Add as Friend")
      end
      within(all(".followee").first) do
        expect(page).to have_content("Add as Friend")
        click_on "Add as Friend"
      end
      within(all(".followee")[3]) do
        expect(page).to have_no_content("Add as Friend")
      end
    end
    within(".friends") do
      expect(page).to have_content(ENV["FRIEND_1"])
      expect(page).to have_content(ENV["FRIEND_2"])
      expect(page).to have_no_content(ENV["NOT_FRIEND"])
    end
  end
  it 'can open POST route to fail gracefully' do
    user = create(:user, token: ENV["GITHUB_API_KEY"])
    user_2 = create(:user, github_username: ENV["FRIEND_1"])
    user_3 = create(:user, github_username: ENV["FRIEND_2"])
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit "/dashboard"

    within(all(".follower").first) do
      click_on "Add as Friend"
    end

    page.driver.post "/friendships?name=#{ENV['NOT_FRIEND']}"
    visit "/dashboard"

    within(".friends") do
      expect(page).to have_no_content(ENV["NOT_FRIEND"])
    end
    expect(page).to have_content("Invalid Friend")
  end
end
