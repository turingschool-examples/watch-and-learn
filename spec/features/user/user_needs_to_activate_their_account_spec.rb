require 'rails_helper'

RSpec.describe 'as a new user' do
  context 'when i create my account' do
    it 'tells me to activate my account and sends and email to do so' do
      #As a guest user
      # When I visit "/"
      visit root_path
      # And I click "Register"
      click_link "Register"
      # Then I should be on "/register"
      expect(current_path).to eq(register_path)
      # And when I fill in an email address (required)
      # And I fill in first name (required)
      # And I fill in password and password confirmation (required)
      first_name = 'testerman'

      fill_in 'Email', with: 'test@mail.com'
      fill_in 'First name', with: first_name
      fill_in 'Last name', with: 'testerson'
      fill_in 'Password', with: 'password'
      fill_in 'Password confirmation', with: 'password'

      # And I click submit
      click_button "Create Account"
      # Then I should be redirected to "/dashboard"
      inactive_user = User.last
      expect(current_path).to eq(dashboard_path)
      # And I should see a message that says "Logged in as <SOME_NAME>"
      expect(page).to have_content("Logged in as #{first_name}")
      # And I should see a message that says "This account has not yet been activated. Please check your email."
      expect(page).to have_content('This account has not yet been activated. Please check your email.')
      expect(page).to have_content('Status: Inactive')
      # As a non-activated user
      # When I check my email for the registration email
      # I should see a message that says "Visit here to activate your account."
      # And when I click on that link
      visit activation_path(inactive_user)
      active_user = User.last
      expect(page).to have_content('Thank you! Your account is now activated.')
      # change status to active for better readability/logic
      expect(active_user.status).to eq(true)
      # Then I should be taken to a page that says "Thank you! Your account is now activated."

      # And when I visit "/dashboard"
      visit dashboard_path
      # Then I should see "Status: Active"
      expect(page).to have_content('Status: Active')
    end
  end
end
