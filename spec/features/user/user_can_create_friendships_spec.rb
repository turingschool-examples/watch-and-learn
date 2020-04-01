require 'rails_helper'
RSpec.describe 'A registered user' do
  describe 'user can create friendships' do
    before :each do
      @user1 = create(:user, github_token: ENV['GITHUB_USER_TOKEN'], github_username: 'DavidHoltkamp1')

      @user2 = create(:user, github_username: 'philjdelong')

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user1)
    end

    it 'I can see add friend link next to users in database that are following me on github' do
      visit dashboard_path

      within ".follower-#{@user2.github_username}" do
        expect(page).to have_link("Add Friend")
      end

      within ".follower-PaulDebevec" do
        expect(page).to_not have_link('Add Friend')
      end
    end

    it 'I can see add friend link next to those users in database that I am following on github' do
      visit dashboard_path

      within ".following-#{@user2.github_username}" do
        expect(page).to have_link('Add Friend')
      end

      within ".following-PaulDebevec" do
        expect(page).to_not have_link('Add Friend')
      end
    end

    it 'I see a section of users that I have friended' do
      friend1 = create(:user, github_username: 'mel-rob')
      friend2 = create(:user, github_username: 'philjdelong')
      non_friend = create(:user, github_username: 'non-friend')

      @user1.friends << [friend1, friend2]

      visit dashboard_path

      expect(page).to have_content('Friends')

      within '.friends' do
        expect(page).to have_content(friend1.github_username)
        expect(page).to have_content(friend2.github_username)
        expect(page).to_not have_content(non_friend.github_username)
      end
    end

    it 'I can friend a user I am following' do
      visit dashboard_path

      within '.friends' do
        expect(page).to_not have_content(@user2.first_name)
        expect(page).to_not have_content(@user2.last_name)
        expect(page).to_not have_content(@user2.github_username)
      end

      within ".following-#{@user2.github_username}" do
        click_link('Add Friend')
      end

      expect(current_path).to eq(dashboard_path)

      within '.friends' do
        expect(page).to have_content(@user2.first_name)
        expect(page).to have_content(@user2.last_name)
        expect(page).to have_content(@user2.github_username)
      end
    end

    it 'I can friend a user who is following me' do
      visit dashboard_path

      within '.friends' do
        expect(page).to_not have_content(@user2.first_name)
        expect(page).to_not have_content(@user2.last_name)
        expect(page).to_not have_content(@user2.github_username)
      end

      within ".following-#{@user2.github_username}" do
        click_link('Add Friend')
      end

      expect(current_path).to eq(dashboard_path)

      within '.friends' do
        expect(page).to have_content(@user2.first_name)
        expect(page).to have_content(@user2.last_name)
        expect(page).to have_content(@user2.github_username)
      end
    end
  end
end
