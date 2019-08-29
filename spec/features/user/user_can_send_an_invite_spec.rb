require 'rails_helper'

describe 'As registered user I can send email invites' do
  before :each do
    stub_dashboard_api_calls
    stub_github_oauth

    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit dashboard_path

    click_on "Send an Invite"
    expect(current_path).to eq(invite_path)
  end

  it 'if the user has an email address associated with their github account' do

    save_and_open_page
    fill_in "Github Handle", with: "jmejia"
    click_on "Send Invite"
    expect(current_path).to eq(dashboard_path)
    expect(current_page).to have_content("Successfully sent invite!")

  end
  # 
  # it 'error message displays if the user does not have an associated email address' do
  #
  #   fill_in "Github Handle", with: "invalid_github_handle"
  #   click_on "Send Invite"
  #   expect(current_path).to eq(dashboard_path)
  #   expect(current_page).to have_content("The Github user you selected doesn't have an email address associated with their account.")
  # end
end

# Email should read as follows:

# Hello <INVITEE_NAME_AS_IT_APPEARS_ON_GITHUB>,
#
# <INVITER_NAME_AS_IT_APPEARS_ON_GITHUB> has invited you to join <YOUR_APP_NAME>. You can create an account <here (should be a link to /signup)>.
