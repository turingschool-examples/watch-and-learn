# frozen_string_literal: true

require "rails_helper"

describe "As registered user" do
  describe "on the dashboard" do
    it "sees a link to add a friend", :vcr do
      user_1 = create(:user, github_token: ENV["GITHUB_PAT"])
      user_2 = create(:user, github_username: "lpile")

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)

      visit dashboard_path

      save_and_open_page
      within("#follower-1") do
        expect(page).to_not have_link("Add Friend")
      end

      within("#follower-7") do
        expect(page).to have_link("Add Friend")
      end

      within("#following-3") do
        expect(page).to have_link("Add Friend")
      end

      within("#following-1") do
        expect(page).to_not have_link("Add Friend")
      end
    end
  end
end
