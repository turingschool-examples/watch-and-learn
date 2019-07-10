require 'rails_helper'

RSpec.describe 'As a registered user' do
  describe 'On my dashboard' do

    it "can invite other github users to use app", :vcr do
      user = create(:user)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit dashboard_path

      click_button 'Send an Invite'

      expect(current_path).to eq(invite_path)

      fill_in :invite, with: 'milevy1'
      click_button "Send Invite"

      expect(current_path).to eq(dashboard_path)
      expect(page).to have_content("Successfully sent invite!")
    end

    it "cant invite other github users to use app with invalid handle", :vcr do
      user = create(:user)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit dashboard_path

      click_button 'Send an Invite'

      expect(current_path).to eq(invite_path)

      fill_in :invite, with: 'asereafdsgdsbauibfef'
      click_button "Send Invite"

      expect(current_path).to eq(dashboard_path)
      expect(page).to have_content("Not a valid Github Handle")
    end

    it "cant invite other github users to use app that don't have an email", :vcr do
      user = create(:user)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit dashboard_path

      click_button 'Send an Invite'

      expect(current_path).to eq(invite_path)

      fill_in :invite, with: 'ryanmillergm'
      click_button "Send Invite"

      expect(current_path).to eq(dashboard_path)
      expect(page).to have_content("The Github user you selected doesn't have an email address associated with their account.")
    end

  end
end
