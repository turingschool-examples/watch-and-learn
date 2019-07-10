require 'rails_helper'

# As a registered user
# When I visit /dashboard
# And I click "Send an Invite"
# Then I should be on /invite
#
# And when I fill in "Github Handle" with <A VALID GITHUB HANDLE>
# And I click on "Send Invite"
# Then I should be on /dashboard
# And I should see a message that says "Successfully sent invite!" (if the user has an email address associated with their github account)
# Or I should see a message that says "The Github user you selected doesn't have an email address associated with their account."

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

    xit "cant invite other github users to use app with invalid handle", :vcr do
      user = create(:user)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit dashboard_path

      click_button 'Send an Invite'

      expect(current_path).to eq(invite_path)

      fill_in :invite, with: 'asereafdsgdsbauibfef'
      click_button "Send Invite"

      expect(current_path).to eq(dashboard_path)
      expect(page).to have_content("The Github user you selected doesn't have an email address associated with their account.")
    end

  end
end
