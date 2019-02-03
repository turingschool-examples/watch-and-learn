require 'rails_helper'

describe 'As a logged in user' do
  describe 'on dashboard page' do
    it 'should see link Add as Friend in followers', :vcr do
      user = create(:user, github_token: ENV['GITHUB_TOKEN'])
      follower = create(:user, github_token: 'pizza', uid: ENV['GITHUB_FOLLOWER_1'])

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit dashboard_path

      within '.github' do
        within first('.follower') do
          expect(page).to have_link('Add as Friend')
        end
      end
    end
    it 'adds friends and shows a list', :vcr do
      user = create(:user, github_token: ENV['GITHUB_TOKEN'])
      follower = create(:user, github_token: 'pizza', uid: ENV['GITHUB_FOLLOWER_1'])
      follower_2 = create(:user, github_token: 'pizza', uid: ENV['GITHUB_FOLLOWER_2'])

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit dashboard_path

      expect(page).to_not have_content('Friends')

      within first('.follower') do
        click_link 'Add as Friend'
      end

      expect(current_path).to eq(dashboard_path)

      within '.friends' do
        expect(page).to have_content(follower.first_name)
        expect(page).to have_content(follower.last_name)
        expect(page).to_not have_content(follower_2.first_name)
        expect(page).to_not have_content(follower_2.last_name)
      end
    end
    it 'can see link Add as Friend for following', :vcr do
      user = create(:user, github_token: ENV['GITHUB_TOKEN'])
      following = create(:user, github_token: 'pizza', uid: ENV['GITHUB_FOLLOWING_1'])

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit dashboard_path

      within '.github' do
        within first('.following') do
          expect(page).to have_link("Add as Friend")
        end
      end
    end
    it 'adds friends and shows a list from followings', :vcr do
      user = create(:user, github_token: ENV['GITHUB_TOKEN'])
      following = create(:user, github_token: 'pizza', uid: ENV['GITHUB_FOLLOWING_1'])
      following_2 = create(:user, github_token: 'pizza', uid: ENV['GITHUB_FOLLOWING_2'])

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit dashboard_path

      expect(page).to_not have_content('Friends')

      within first('.following') do
        click_link 'Add as Friend'
      end

      expect(current_path).to eq(dashboard_path)

      within '.friends' do
        expect(page).to have_content(following.first_name)
        expect(page).to have_content(following.last_name)
        expect(page).to_not have_content(following_2.first_name)
        expect(page).to_not have_content(following_2.last_name)
      end
    end
  end
end
