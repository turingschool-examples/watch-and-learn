require 'rails_helper'

describe "As a registered user connected to Github" do
  context "when my followers/following is also connected to Github" do
    it "I see a button to add them as a friend" do
      april = create(:user, email: "test@email.com", password: "test", github_token: ENV['GITHUB_API_KEY'], github_uid: "41272635")
      mackenzie = create(:user, email: "mackenzie@email.com", password: "test", github_token: ENV['MF_GITHUB_TOKEN'], github_uid: "42525195")
      zach = create(:user, email: "zach@email.com", password: "test", github_token: "faketoken", github_uid: "34927114")

      repos_json_response = File.open('fixtures/user_repos.rb')
      stub_request(:get, "https://api.github.com/user/repos").to_return(status: 200, body: repos_json_response)

      followers_json_response = File.open('fixtures/user_followers.rb')
      stub_request(:get, "https://api.github.com/user/followers").to_return(status: 200, body: followers_json_response)

      following_json_response = File.open('fixtures/user_following.rb')
      stub_request(:get, "https://api.github.com/user/following").to_return(status: 200, body: following_json_response)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(april)

      visit dashboard_path

      within ".following_handle_unrealities" do
        expect(page).to_not have_button("Add Friend")
      end
      within ".following_handle_teresa-m-knowles" do
        expect(page).to_not have_button("Add Friend")
      end
      within ".following_handle_nagerz" do
        expect(page).to have_button("Add Friend")
      end
      within ".following_handle_PeregrineReed" do
        expect(page).to_not have_button("Add Friend")
      end
      within ".following_handle_plapicola" do
        expect(page).to_not have_button("Add Friend")
      end
    end
  end
end
