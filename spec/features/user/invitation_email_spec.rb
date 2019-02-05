require 'rails_helper'

describe 'a registered user on the dashboard page' do
  it 'can invite someone with a github handle to the account' do
    user_1 = create(:user, email_activation_status: :unactivated)
    github_handle = 'testtest'
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)

    visit dashboard_path

    expect(page).to have_link('Send an Invite')

    click_on 'Send an Invite'

    expect(current_path).to eq(new_invite_path)

    fill_in :invite_github_handle, with: github_handle
    click_on 'Send Invite'

    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content('Successfully sent invite!')
    expect(page).to_not have_content("The Github user you selected doesn't have an email address associated with their account.")
  end
end
