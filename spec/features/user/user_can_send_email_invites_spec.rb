require 'rails_helper'

describe 'as a registered user' do
  describe 'when they visit the dashboard' do
    it 'can send an invite' do
      user_1 = create(:user, github_token: ENV["GITHUB_TOKEN"])
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)

      visit dashboard_path

      expect(page).to have_button("Send an Invite")

      click_button "Send an Invite"
      expect(current_path).to eq('/invite')
      fill_in :github_handle, with: "stoic-plus"
      click_on "Send Invite"
      expect(current_path).to eq(dashboard_path)
      expect(page).to have_content("Successfully sent invite!")
    end
    it 'returns message that contact does not have email address' do
      user_1 = create(:user, github_token: ENV["GITHUB_TOKEN"])
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)

      visit dashboard_path

      expect(page).to have_button("Send an Invite")

      click_button "Send an Invite"
      expect(current_path).to eq('/invite')
      fill_in :github_handle, with: "danbriechle"
      click_on "Send Invite"

      expect(current_path).to eq(dashboard_path)
      expect(page).to have_content("The Github user you selected doesn't have an email address associated with their account.")
    end
  end
end
