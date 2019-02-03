require 'rails_helper'

describe 'As a logged in user' do
  describe 'on dashboard page' do
    it 'should see link Add as Friend in followers', :vcr do
      user = create(:user, github_token: ENV['GITHUB_TOKEN'])
      follower = create(:user, github_token: 'pizza', uid: '22285337')

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit dashboard_path

      within '.github' do
        expect(page).to have_link('Add as Friend', count: 1)
        within first('.follower') do
          expect(page).to have_link('Add as Friend')
        end
      end
    end
    it 'adds friends and shows a list', :vcr do
      user = create(:user, github_token: ENV['GITHUB_TOKEN'])
      follower = create(:user, github_token: 'pizza', uid: '22285337')
      follower_2 = create(:user, github_token: 'pizza', uid: '42525195')

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
  end
end
