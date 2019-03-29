# frozen_string_literal: true

require 'rails_helper'

describe 'A registered user' do
  context 'visiting /dashboard' do
    it 'can add followers or followings that have linked their account to github as friends' do
      user = create(:user, github_token: ENV['github_key'])
      user1 = create(:user, uid: 25_069_483, first_name: 'TestName', github_username: 'stiehlrod')

      mock_user_dashboard_github

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit dashboard_path

      expect(user.friends).to eq([])
      expect(page.has_content?('Friends')).to be(true)
      within '.friends' do
        expect(page.has_content?(user1.github_username)).to be(false)
      end

      within '.followers' do
        click_button('Add Friend')
      end

      expect(page.has_current_path?(dashboard_path)).to be(true)
      expect(user.friends[0].is_a?(User)).to be(true)
      within '.friends' do
        expect(page.has_content?(user1.github_username)).to be(true)
      end
    end
  end
end
