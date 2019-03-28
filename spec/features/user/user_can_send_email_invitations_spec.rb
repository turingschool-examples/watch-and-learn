# frozen_string_literal: true

require 'rails_helper'

describe 'A registered user' do
  context 'visiting /dashboard' do
    it 'can send an email invite to a github user who has an email' do
      WebMock.disable!
      user = create(:user, github_token: ENV['github_key'], github_username: 'User')
      login_as(user)
      visit dashboard_path

      click_on 'Send an Invite'

      expect(page.has_current_path?('/invite')).to be(true)
      fill_in 'github_handle', with: 'manojpanta'
      ## manojpanta has a public email address
      click_button 'Send Invite'
      expect(page.has_current_path?('/dashboard')).to be(true)
      expect(page.has_content?('Successfully sent invite!')).to be(true)
    end
    it 'cannot send an email invite to a github user with no email', :vcr do
      user = create(:user, github_token: ENV['github_key'], github_username: 'User')
      login_as(user)
      visit dashboard_path

      click_on 'Send an Invite'

      expect(page.has_current_path?('/invite')).to be(true)
      fill_in 'github_handle', with: 'csvlewis'
      ## csvlewis  does not have a public email address
      click_button 'Send Invite'

      expect(page.has_current_path?('/dashboard')).to be(true)
      expect(page.has_content?("The Github user you selected doesn\'t have an email address associated with their account!")).to be(true)
    end
  end
end
