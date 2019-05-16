require 'rails_helper'

RSpec.describe 'as a logged in user that has linked a github' do
  context 'when I visit my dashboard', :vcr do
    it 'can add other users who have linked their github as friends from followed accounts' do
      user = create(:user)
      friend_user = create(:user, github_name: 'tnodland', token: ENV['GITHUB_FRIEND_TOKEN'])
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit dashboard_path

      expect(user.friends.count).to eq(0)

      within '.friends' do
        expect(page).to_not have_content(friend_user.github_name)
      end

      within '.following' do
        expect(page.all('.li').first).to_not have_link('Add Friend')
        click_link 'Add Friend'
      end

      expect(current_path).to eq(dashboard_path)
      expect(page).to have_content("Successfully added #{friend_user.github_name} as a friend")
      expect(user.friends.count).to eq(1)

      within '.following' do
        expect(page).to_not have_link('Add Friend')
      end

      within '.friends' do
        expect(page).to have_content('People you have friended')
        expect(page).to have_content(friend_user.github_name)
      end
    end

    it 'does not add a firend if the id is not valid' do
      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit users_add_friend_path('partical')

      expect(page).to have_content('partical is not a valid user')
    end
  end
end
