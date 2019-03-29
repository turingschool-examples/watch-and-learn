# frozen_string_literal: true

require 'rails_helper'

describe 'A registered user' do
  context 'visiting /dashboard' do
    # rubocop:disable Metrics/LineLength
    it 'can add followers or followings that have linked their account to github as friends' do
      user = create(:user, github_token: ENV['github_key'])
      user1 = create(:user, uid: 25_069_483, first_name: 'TestName', github_username: 'stiehlrod')

      mock_user_dashboard_github

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      # rubocop:enable Metrics/LineLength

      visit dashboard_path

      expect(user.friends).to eq([])
      expect(page).to have_content('Friends')
      within '.friends' do
        expect(page).to_not have_content(user1.github_username)
      end

      within '.followers' do
        click_button('Add Friend')
      end

      expect(current_path).to eq(dashboard_path)
      expect(user.friends[0]).to be_a(User)
      within '.friends' do
        expect(page).to have_content(user1.github_username)
      end
    end
  end
end
