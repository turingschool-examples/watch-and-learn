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

  it "can add user's GitHub friends" do
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
    # binding.pry
    expect(user.friendships.first.friendship_user_id).to eq(follower_user.id)

    within "#follower-#{follower_user.github_id}" do
      expect(page).to_not have_button("Add Friend")
    end

  end
end
