# frozen_string_literal: true

require 'rails_helper'

describe 'A registered user' do
  context 'visiting /dashboard' do
    it 'can send an email invite to a github user who has an email', :vcr do
      mock_user_dashboard_github
      # rubocop:disable Metrics/LineLength
      user = create(:user, github_token: ENV['github_key'], github_username: 'User')
      # rubocop:enable Metrics/LineLength
      login_as(user)
      visit dashboard_path

      click_on 'Send an Invite'

      expect(current_path).to eq('/invite')
      fill_in 'github_handle', with: 'manojpanta'
      ## manojpanta has a public email address
      click_button 'Send Invite'
      expect(current_path).to eq('/dashboard')
      expect(page).to have_content('Successfully sent invite!')
    end
    it 'cannot send an email invite to a github user with no email', :vcr do
      # rubocop:disable Metrics/LineLength
      user = create(:user, github_token: ENV['github_key'], github_username: 'User')
      # rubocop:enable Metrics/LineLength
      login_as(user)
      visit dashboard_path

      click_on 'Send an Invite'

      expect(current_path).to eq('/invite')
      fill_in 'github_handle', with: 'csvlewis'
      ## csvlewis  does not have a public email address
      click_button 'Send Invite'

      expect(current_path).to eq('/dashboard')
      # rubocop:disable Metrics/LineLength
      expect(page).to have_content("The Github user you selected doesn\'t have an email address associated with their account!")
      # rubocop:enable Metrics/LineLength
    end
  end
end
