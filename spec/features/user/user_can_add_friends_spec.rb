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
# rails g migration AddNicknameToUsers github_username:string
# Details: We want to create friendships between users with accounts in our
# database. Long term we want to make video recommendations based on what
# friends are bookmarking. This card should not include the recommendation logic.
# That's coming in a different user story.
# #
# # Background: A user (Josh) exists in the system with a Github token. The user
#  has two followers on Github. One follower (Dione) also has an account within
#  our database. The other follower (Mike) does not have an account in our system.
#  If a follower or following has an account in our system we want to include a link
#  next to their name to allow us to add as a friend.
# #
# # In this case Dione would have an Add as Friend link next to her name.
#  Mike would not have the link next to his name.
# #
# # Tips: No need to work on edge cases during your spike. You'll want to
# research self referential has_many through. Here's a good starting point to
# understand the concept: http://blog.hasmanythrough.com/2007/10/30/self-
# referential-has-many-through. You'll probably need to do more googling but
# that's part of the fun ;)
# #
# #  Links show up next to followers that have accounts in our system.
# #  Links show up next to followings that have accounts in our database.
# #  Links do not show up next to followers or followings if they are not in our database.
# #  There's a section on the dashboard that shows all of the users that I have friended
#  Edge Case: Make sure this fails gracefully. If you open up a POST route to create a friendship, be sure to catch the scenario where someone sends an invalid user id. Send a flash message alerting them of the error.
