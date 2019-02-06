require 'rails_helper'

describe 'User Friendships' do
  describe 'as a logged in user with followers' do
    xit 'shows a link to add a friend' do
      user = create(:user, github_token: ENV["GITHUB_TOKEN"])
      token = user.github_token

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      followers = Follower.find_all_followers(token)

      follower_wanda = Follower.new(login: "wandadog", html_url: "https://github.com/wandadog", uid: user.attributes["id"])

      followers << follower_wanda
      new_followers = followers.reverse!

      follower_2 = new_followers.first
      follower_1 = new_followers.second
      visit '/dashboard'

      within ('.followers-list') do
        within (".follower-#{follower_1.login}") do
          expect(page).to_not have_link("Add as Friend")
        end
        expect(page).to have_link("Add #{follower_2.login} as Friend")

      end
    end
    describe 'as a logged in user with followings' do
      xit 'shows a link to add a friend' do
      end
    end
  end
end
