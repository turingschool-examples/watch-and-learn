# frozen_string_literal: true

require "rails_helper"

describe "As registered user" do
  describe "on the dashboard" do
    it "sees a link to add a friend", :vcr do
      user_1 = create(:user, github_token: ENV["GITHUB_PAT"])
      user_2 = create(:user, github_username: "lpile")

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)

      visit dashboard_path

      within("#follower-1") do
        expect(page).to_not have_button("Add Friend")
      end

      within("#follower-7") do
        expect(page).to have_button("Add Friend")
      end

      within("#following-3") do
        expect(page).to have_button("Add Friend")
      end

      within("#following-1") do
        expect(page).to_not have_button("Add Friend")
      end
    end

    it "can add friend", :vcr do
      user_1 = create(:user, github_token: ENV["GITHUB_PAT"])
      user_2 = create(:user, github_username: "lpile")

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)

      visit dashboard_path

      within("#follower-7") do

        click_button "Add Friend"

      end
      expect(current_path).to eq(dashboard_path)

      within("#friends") do
        expect(page).to have_content(user_2.github_username)
      end
    end
  end
end
