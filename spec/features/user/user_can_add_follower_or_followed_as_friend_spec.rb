require 'rails_helper'

describe "as a user" do
  it "can see a button to friend a follower and that follower will now be in the users friends", :vcr do
    user_1 = create(:user, token: ENV['GITHUB_TOKEN'])
    user_2 = create(:user, github_handle: "jfangonilo")

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)

    visit "/dashboard"

    within(first(".followers")) do
      expect(page).to have_link("jfangonilo")
      expect(page).to have_link("Add as Friend")
    end

    within(second(".followers")) do
      expect(page).to have_link("danmoran-pro")
      expect(page).not_to have_link("Add as Friend")
    end
  end
end
