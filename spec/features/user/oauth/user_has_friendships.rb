require 'rails_helper'

RSpec.describe 'As a user from my dashboard' do
  it 'I can add a friend that is connect to github' do
    user = create(:user, token: ENV['MY_TOKEN'], connected?: true, handle: 'lrs8810')
    user_2 = create(:user, first_name: 'Robert', last_name: 'Tomato', token: 'friend', connected?: true, handle: 'Bob')

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    follower_1 = Follower.new({login:'Bob' , html_url: "https://github.com/lrs8810/brownfield-of-dreams"})
    follower_2 = Follower.new({login:'Bob2' , html_url: "https://github.com/lrs8810/brownfield-of-dreams"})
    follower_3 = Follower.new({login:'Bob3' , html_url: "https://github.com/lrs8810/brownfield-of-dreams"})

    followers = [follower_1, follower_2, follower_3]

    repos = []
    followings = []

    allow_any_instance_of(UserFacade).to receive(:repos).and_return(repos)
    allow_any_instance_of(UserFacade).to receive(:followers).and_return(followers)
    allow_any_instance_of(UserFacade).to receive(:followings).and_return(followings)

    visit dashboard_path

    within ".follower-#{follower_1.handle}" do
      click_button 'Add friend'
    end

    expect(current_path).to eq(dashboard_path)

    expect(page).to have_content('Added friend!')

    user.reload
    visit dashboard_path

    within ".follower-#{follower_1.handle}" do
      expect(page).to_not have_button('Add friend')
    end

    within ".friend-#{user_2.id}" do
      expect(page).to have_content("#{user_2.handle} | #{user_2.first_name} #{user_2.last_name}")
    end
  end
end
