require 'rails_helper'

describe 'A visitor' do
  context 'registers an account' do
    it 'receives an activation link' do
      WebMock.disable!
      visit '/'
      click_on 'Register'
      expect(current_path).to eq('/register')

      fill_in 'user[email]', with: 'manojpanta95@gmail.com'
      fill_in 'user[first_name]', with: 'manoj1'
      fill_in 'user[last_name]', with: 'manoj'
      fill_in 'user[password]', with: 'abcd'
      fill_in 'user[password_confirmation]', with: 'abcd'
      click_on 'Create Account'

      expect(current_path).to eq('/dashboard')
      expect(User.first.activation_token).to be_a(String)
      expect(User.first.activated).to eq(false)

      expect(page).to have_content("Logged in as manoj1")
      expect(page).to have_content("This account has not yet been activated. Please check your email.")
    end
  end
end
