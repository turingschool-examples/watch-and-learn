require 'rails_helper'

describe 'As a registered user' do
  it 'I can send an email invite to another GitHub user
      by clicking an invite link on my dashboard', :vcr do

    token = ENV["GITHUB_TOKEN_LOCAL"]
    user = create(:user, token: token)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit dashboard_path

    click_button 'Send an Invite'
    expect(current_path).to eq(invite_path)
    fill_in 'github_handle', with: 'darren2802'
    click_button 'Send Invite'
    expect(current_path).to eq(dashboard_path)
  end
end


# As a registered user
# When I visit /dashboard
# And I click "Send an Invite"
# Then I should be on /invite
#
# And when I fill in "Github Handle" with <A VALID GITHUB HANDLE>
# And I click on "Send Invite"
# Then I should be on /dashboard
# And I should see a message that says "Successfully sent invite!" (if the user
# has an email address associated with their github account)
# Or I should see a message that says "The Github user you selected doesn't have
# an email address associated with their account."
# The email should read as follows
#
# Hello <INVITEE_NAME_AS_IT_APPEARS_ON_GITHUB>,
#
# <INVITER_NAME_AS_IT_APPEARS_ON_GITHUB> has invited you to join
# <YOUR_APP_NAME>. You can create an account <here (should be a link to /signup)>.
