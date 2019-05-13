require 'rails_helper'

RSpec.describe 'As a user', type: :feature do
  describe 'when I visit my dashboard', :vcr do
    it 'allows me to invite people to the website' do
      # As a registered user
      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      # When I visit /dashboard
      visit dashboard_path
      # And I click "Send an Invite"

      click_link "Send an Invite"

      # Then I should be on /invite
      expect(current_path).to eq(invite_path)
      expect(page).to have_content("Enter Your Friend's GitHub Usename and we'll invite them to join!")

      # And when I fill in "Github Handle" with <A VALID GITHUB HANDLE>
      fill_in :github_handle, with: "test-freind"
      # And I click on "Send Invite"
      click_button "Send Invite"
      # Then I should be on /dashboard
      expect(current_path).to eq(dashboard_path)
      # And I should see a message that says "Successfully sent invite!" (if the user has an email address associated with their github account)
      expect(page).to have_content("Successfully sent invite!")
    end

    it 'will show an error if there is no email attached to their github account' do
      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      visit dashboard_path

      click_link "Send an Invite"

      expect(current_path).to eq(invite_path)

      fill_in :github_handle , with: "tnodland"
      click_button "Send Invite"
      failure = "The Github user you selected doesn't have an email address associated with their account."

      expect(current_path).to eq(dashboard_path)
      expect(page).to have_content(failure)
    end

    it 'will show an error if the github handle does not exist' do
      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      visit dashboard_path

      click_link "Send an Invite"

      expect(current_path).to eq(invite_path)

      fill_in :github_handle , with: "lbivlodfbnvolidarbvlhdrsbvlksdanv"
      click_button "Send Invite"
      failure = "The Github user you selected doesn't have an email address associated with their account."

      expect(current_path).to eq(dashboard_path)
      expect(page).to have_content(failure)
    end
  end
end
