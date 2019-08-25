require 'rails_helper'

feature 'as a user when I visit my dashboard' do
  scenario 'I can connect to Github with a link styled like a button' do
    stub_dashboard_api_calls
    stub_github_oauth

    josh = create(:user)
    josh.token = ENV["GITHUB_API_KEY"]
    dani = create(:user)
    dani.token = ENV["GITHUB_API_KEY_2"]
    madi = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(josh)

    visit dashboard_path

    within ".followers" do
      expect(page).to have_link("")
  end
end
# Background: A user (Josh) exists in the system with a Github token. The user
# has two followers on Github. One follower (Dione) also has an account within
# our database. The other follower (Mike) does not have an account in our system.
# If a follower or following has an account in our system we want to include a
# link next to their name to allow us to add as a friend.
#
# In this case Dione would have an Add as Friend link next to her name.
#   Mike would not have the link next to his name.
