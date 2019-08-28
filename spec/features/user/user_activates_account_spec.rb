require 'rails_helper'


describe 'As a inactive user' do
  describe 'When I check my email for the registration email' do
    it "I can activate my account" do
      email = 'jimbob@aol.com'
      first_name = 'Jim'
      last_name = 'Bob'
      password = 'password'

      visit '/'

      click_on 'Sign In'

      expect(current_path).to eq(login_path)

      click_on 'Sign up now.'

      expect(current_path).to eq(new_user_path)

      fill_in 'user[email]', with: email
      fill_in 'user[first_name]', with: first_name
      fill_in 'user[last_name]', with: last_name
      fill_in 'user[password]', with: password
      fill_in 'user[password_confirmation]', with: password

      click_on'Create Account'

      expect(page).to have_content("Please check your email for account activation.")

      user = User.last
      email = open_email(user.email)
      expect(email).to deliver_to(user.email)


      page.driver.submit :patch, "/activate_account/#{user.id}", {}

      expect(current_path).to eq(dashboard_path)
      expect(page).to have_content('Your account has been activated.')
      expect(page).to have_content('Status: active')
    end
  end
end
