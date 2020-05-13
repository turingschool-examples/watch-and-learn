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
