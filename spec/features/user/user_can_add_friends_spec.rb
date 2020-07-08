require 'rails_helper'

describe 'a user dashboard' do
  it 'allows a user to add friends' do
    user_2 = create(:user)
    user_2.update(github_token: ENV["GITHUB_TOKEN_A"], github_username: ENV["GITHUB_USERNAME_A"])
    user_3 = create(:user)
    user_3.update(github_token: ENV["GITHUB_TOKEN_B"], github_username: ENV["GITHUB_USERNAME_B"])
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_2)

    visit dashboard_path

    within ".follower-#{ENV["GITHUB_USERNAME_C"]}" do
      expect(page).not_to have_button('Add as Friend')
    end

    within ".follower-#{ENV["GITHUB_USERNAME_B"]}" do
      click_button 'Add as Friend'
    end
    new_friend = Friendship.last
    expect(new_friend.user_id).to eq(user_2.id)
    expect(new_friend.friend_id).to eq(user_3.id)
    expect(current_path).to eq(dashboard_path)
    within ".follower-#{ENV["GITHUB_USERNAME_B"]}" do
      # expect(page).not_to have_link('Add as Friend')
    end
    within ".friends" do
      expect(page).to have_content(ENV["GITHUB_USERNAME_B"])
    end
  end
  it 'prevents bad IDs from becoming friends' do
    user_2 = create(:user)
    user_2.update(github_token: ENV["GITHUB_TOKEN_A"], github_username: ENV["GITHUB_USERNAME_A"])

    visit root_path
    page.driver.post("/users/" + "9000" + "/friends?github_username=" + user_2.github_username)
    expect(Friendship.all).to eq([])
    expect(page).to have_content("You are being redirected.")

    page.driver.post("/users/" + "#{user_2.id}" + "/friends?github_username=" + "junkuser")
    expect(Friendship.all).to eq([])
    expect(page).to have_content("You are being redirected.")
  end
end
