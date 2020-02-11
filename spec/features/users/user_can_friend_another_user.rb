# Background: A user (Josh) exists in the system with a Github token. The user has two followers on Github.
#  One follower (Dione) also has an account within our database. The other follower (Mike) does not have an account in our
# system. If a follower or
# following has an account in our system we want to include a link next to their name to allow us to add as a friend.

require 'rails_helper'

describe "As a user we can go to our dashboard" do
  scenario "we see a link to friend a follower or followee if they are in our database", :vcr do
    token = ENV["GITHUB_TOKEN_LOCAL"]
    user = create(:user, token: token)
    user_2 = create(:user, uid: "37692413")


    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    allow_any_instance_of(ApplicationController).to receive(:github_status).and_return("logged in")

    visit dashboard_path

    within (".github_followers") do
      expect(page).to have_link("Friend this User")
      click_link "Friend this User"
    end


  end
end
