require 'rails_helper'

describe '/dashboard page' do
  it 'send invitation' do
    user = create(:user, github_id: '29346170', token: ENV['GITHUB_ACCESS_TOKEN'])
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit '/dashboard'

    click_on "Send Invitation"

    expect(current_path).to eq('/invite')

    fill_in :github_handle, with: 'hale4029'
    click_on('Send Invite')

    expect(current_path).to eq('/dashboard')
    expect(page).to have_content("Successfully sent invite!")


    click_on "Send Invitation"

    fill_in :github_handle, with: 'hale4027'
    click_on('Send Invite')

    expect(current_path).to eq('/dashboard')
    expect(page).to have_content("The Github user you selected doesn't have an email address associated with their account.")
  end
end
