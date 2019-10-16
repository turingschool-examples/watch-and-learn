require 'rails_helper'

describe 'user friendships' do

  before :each do
    repo_json_response = File.open('./spec/fixtures/github_repo_data.json')

    stub_request(:get, "https://api.github.com/user/repos")
    .to_return(status: 200, body: repo_json_response)

    follower_json_response = File.open('./spec/fixtures/github_follower_data.json')

    stub_request(:get, "https://api.github.com/user/followers")
    .to_return(status: 200, body: follower_json_response)

    following_json_response = File.open('./spec/fixtures/github_following_data.json')

    stub_request(:get, "https://api.github.com/user/following")
    .to_return(status: 200, body: following_json_response)
  end

  it "can add user's GitHub friends who is follower" do
    user = create(:user, github_id: 123, github_token: ENV["GITHUB_API_KEY"])
    follower_user = create(:user, github_id: 36523304)
    non_user_follower = GithubUser.new({id: "47948268",
                                        login: "matthewdshepherd",
                                        html_url: "https://github.com/matthewdshepherd" })

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit dashboard_path

    within ".github-followers" do
      within "#follower-#{non_user_follower.github_id}" do
        expect(page).to_not have_button("Add Friend")
      end

      within "#follower-#{follower_user.github_id}" do
        click_button "Add Friend"
      end
    end

    within "#follower-#{follower_user.github_id}" do
      expect(page).to_not have_button("Add Friend")
    end

    within ".friends" do
      expect(page).to have_content("Friends")
      expect(page).to have_content(follower_user.first_name)
    end
  end

  it "can add user's GitHub friends who is following" do
    user = create(:user, github_id: 123, github_token: ENV["GITHUB_API_KEY"])
    following_user = create(:user, github_id: 23268508)
    non_user_following = GithubUser.new({id: "24374609",
                                        login: "corneliusellen",
                                        html_url: "https://github.com/corneliusellen" })

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit dashboard_path

    within ".github-following" do
      within "#following-#{non_user_following.github_id}" do
        expect(page).to_not have_button("Add Friend")
      end

      within "#following-#{following_user.github_id}" do
        click_button "Add Friend"
      end
    end

    within "#following-#{following_user.github_id}" do
      expect(page).to_not have_button("Add Friend")
    end

    within ".friends" do
      expect(page).to have_content("Friends")
      expect(page).to have_content(following_user.first_name)
    end
  end

  # it "cannot manually add random user as friend by visiting friendship post route" do
  #   user_1 = create(:user, github_id: 123, github_token: ENV["GITHUB_API_KEY"])
  #   user_2 = create(:user, github_id: 123, github_token: nil)
  #   allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)
  #
  #   visit dashboard_path
  #
  #   visit "/friendships/#{user_1.id}/#{user_2.id}"
  #
  #   expect(current_path).to eq(dashboard_path)
  #
  #   expect(page).to have_content("Cannot add friend at this time.")
  #
  # end
end
