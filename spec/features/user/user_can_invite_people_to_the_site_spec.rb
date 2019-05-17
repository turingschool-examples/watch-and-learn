require 'rails_helper'

RSpec.describe 'As a user', type: :feature do
  describe 'when I visit my dashboard', :vcr do
    it 'allows me to invite people to the website' do
      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit dashboard_path

      click_link 'Send an Invite'

      expect(current_path).to eq(invite_path)
      expect(page).to have_content("Enter Your Friend's GitHub Usename and we'll invite them to join!")

      fill_in :github_handle, with: 'test-freind'
      click_button 'Send Invite'

      expect(current_path).to eq(dashboard_path)
      expect(page).to have_content('Successfully sent invite!')
    end

    it 'will show an error if there is no email attached to their github account' do
      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      visit dashboard_path

      click_link "Send an Invite"

      expect(current_path).to eq(invite_path)

      fill_in :github_handle , with: 'tnodland'
      click_button 'Send Invite'
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

      fill_in :github_handle , with: 'lbivlodfbnvolidarbvlhdrsbvlksdanv'
      click_button 'Send Invite'
      failure = "The Github user you selected doesn't have an email address associated with their account."

      expect(current_path).to eq(dashboard_path)
      expect(page).to have_content(failure)
    end
  end
end
