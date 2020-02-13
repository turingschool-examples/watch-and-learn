require 'rails_helper'

describe "As a logged in User" do
  it "I see a link next to a Github Follower to 'Add Friend' if follower is a Turing Tutorial User", :vcr do
    
    json_response = File.read('spec/fixtures/followers.json')
    stub_request(:get,"https://api.github.com/user/followers").to_return(status: 200, body: json_response)
    user = create(:user, github_token: ENV['GITHUB_ACCESS_TOKEN'], github_username: "jobannon")
    friend_user = create(:user, github_token: ENV['FRIEND_ACCESS_TOKEN'], github_username: "tyladevon")

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit '/dashboard'

    within(first("#followers")) do
      click_on "Add Friend"
    end

    user.reload
    
    expect(current_path).to eq('/dashboard')

    within(first("#followers")) do
      expect(page).to_not have_content("Add Friend")
    end

    within("#friends") do
      expect(page).to have_content(friend_user.github_username)
    end
  end
end
