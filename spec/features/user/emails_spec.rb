require 'rails_helper'

RSpec.describe "As a user,", :vcr do 
  describe "when I visit /dashboard and click send invite" do 
    it "then I should be on /invite, and, when I fill in a Github Handle and click 'Send Invite', then I'm redirected to /dashboard and see a happy path flash message." do 
      @user1 = User.create({email: "fake@example.com",
                        first_name: "David",
                        last_name: "Tran",
                        password: "password",
                        role: "default",
                        token: ENV['GH_TEST_KEY_1']})
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user1)

      visit '/dashboard'
      click_on('Send an Invite')
      
      expect(current_path).to eq('/invite')

      fill_in :gh_username, with: 'jrsewell400'
      click_on 'Send Invite'
      expect(current_path).to eq('/dashboard')
      expect(page).to have_content("Successfully sent invite!")
    end

    it "fill out the form with an invalid Github username, then I see a sad path flash message." do 
      @user1 = User.create({email: "fake@example.com",
                        first_name: "David",
                        last_name: "Tran",
                        password: "password",
                        role: "default",
                        token: ENV['GH_TEST_KEY_1']})
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user1)

      visit '/dashboard'
      click_on('Send an Invite')
      
      expect(current_path).to eq('/invite')

      fill_in :gh_username, with: 'ergqdfvasdfwe'
      click_on 'Send Invite'
      expect(current_path).to eq('/invite')
      expect(page).to have_content("The Github user you selected doesn't have an email address associated with their account.")
    end
  end
end 

# As a registered user
# When I visit /dashboard
# And I click "Send an Invite"
# Then I should be on /invite

# And when I fill in "Github Handle" with <A VALID GITHUB HANDLE>
# And I click on "Send Invite"
# Then I should be on /dashboard
# And I should see a message that says "Successfully sent invite!" (if the user has an email address associated with their github account)
# Or I should see a message that says "The Github user you selected doesn't have an email address associated with their account."

# EMAIL SYNTAX
# Hello <INVITEE_NAME_AS_IT_APPEARS_ON_GITHUB>,

# <INVITER_NAME_AS_IT_APPEARS_ON_GITHUB> has invited you to join <YOUR_APP_NAME>. You can create an account <here (should be a link to /signup)>.