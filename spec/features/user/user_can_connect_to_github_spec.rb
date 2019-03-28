# frozen_string_literal: true

require 'rails_helper'

describe 'A registered user without a github token' do
  context 'visiting /dashboard' do
    it 'can connect their account to github' do
      user = create(:user)
      login_as(user)

      visit dashboard_path
      expect(page.has_content?('Followers')).to be(false)
      expect(page.has_content?('Following')).to be(false)

      mock_user_dashboard_github

      expect(user.github_token).to eq(nil)
      expect(user.github_username).to eq(nil)
      expect(user.uid).to eq(nil)

      click_on 'Connect To Github'

      expect(User.find(user.id).github_token.is_a?(String)).to be(true)
      expect(User.find(user.id).github_username.is_a?(String)).to be(true)
      expect(User.find(user.id).uid.is_a?(Integer)).to be(true)

      expect(page.has_link?('Connect To Github')).to be(false)
      expect(page.has_content?('Followers')).to be(true)
      expect(page.has_content?('Following')).to be(true)
    end

    it 'cannot connect multiple user accounts to the same github account' do
      create(:user, first_name: 'Test name', uid: 34_468_256)
      user = create(:user)

      login_as(user)

      mock_user_dashboard_github
      click_on 'Connect To Github'

      expect(user.uid).to eq(nil)
      expect(user.github_token).to eq(nil)
      expect(page.has_current_path?(dashboard_path)).to be(true)
      expect(page.has_button?('Connect To Github')).to be(true)
      expect(page.has_content?('This GitHub account is already connected to another user\'s profile')).to be(true)
    end
  end
end
