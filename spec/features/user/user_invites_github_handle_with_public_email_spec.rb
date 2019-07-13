# frozen_string_literal: true

require 'rails_helper'

describe 'User logs in with Github' do
  it 'then invites user with public email' do
    # VCR.use_cassette('features/user/user_sends_an_invite') do
    WebMock.disable!
      user = create(:user, active: true, github_token: ENV['GITHUB_TOKEN_J'])

      visit '/'
      click_on 'Sign In'

      fill_in 'session[email]', with: user.email
      fill_in 'session[password]', with: user.password

      click_on 'Log In'
      visit '/dashboard'
      user.reload
      expect(current_path).to eq(dashboard_path)

      click_button 'Send Invite'
      expect(current_path).to eq(invite_path)

      fill_in 'invitee_github_handle', with: 'WHomer'

      expect { click_button 'Send Invite' }
        .to change { ActionMailer::Base.deliveries.count }.by(1)

      expect(current_path).to eq(dashboard_path)
      expect(page).to have_content('Successfully sent invite!')

      # Invitee receives email with link to click on
      visit '/register'
      expect(current_path).to eq(register_path)
    end
  # end
end
