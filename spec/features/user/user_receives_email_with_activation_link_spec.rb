# frozen_string_literal: true

require 'rails_helper'

describe 'A visitor' do
  context 'registers an account' do
    it 'receives an activation link' do
      WebMock.disable!
      visit '/'
      click_on 'Register'
      expect(page.has_current_path?('/register')).to be(true)

      fill_in 'user[email]', with: 'manojpanta95@gmail.com'
      fill_in 'user[first_name]', with: 'manoj1'
      fill_in 'user[last_name]', with: 'manoj'
      fill_in 'user[password]', with: 'abcd'
      fill_in 'user[password_confirmation]', with: 'abcd'
      click_on 'Create Account'

      expect(page.has_current_path?('/dashboard')).to be(true)
      expect(User.first.activation_token.is_a?(String)).to be(true)
      expect(User.first.activated).to eq(false)

      expect(page).to have_content('Logged in as manoj1')
      # rubocop:disable Metrics/LineLength
      expect(page).to have_content('This account has not yet been activated. Please check your email.')
      # rubocop:enable Metrics/LineLength
    end

    context 'that has registered an account' do
      it 'can activate their account via a link in their email' do
        user = create(:user, activation_token: 'bsdjhfbjksbdckbs')
        login_as(user)
        mock_user_dashboard_github
        visit dashboard_path
        expect(User.find(user.id).activated).to eq(false)
        expect(page).to_not have_content('Status: Active')

        visit '/activation?token=bsdjhfbjksbdckbs'

        expect(page.has_current_path?(dashboard_path)).to be(true)
        expect(User.find(user.id).activated).to eq(true)
        expect(page).to have_content('Status: Active')
      end
    end
  end
end
