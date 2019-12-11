require 'rails_helper'

describe 'A registered user' do
  before :each do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit dashboard_path

    click_button 'Send an Invite'

    expect(current_path).to eq(invite_path)
  end

  xit 'can send an invite to a valid github handle', :vcr do
    user_2 = create(:user, handle: 'BabsLabs')

    fill_in 'invite[handle]', with: user_2.handle

    click_button 'Send Invite'

    expect(page).to have_content('Successfully sent invite!')
  end

  xit 'sees an error message if an invite is sent to an invalid github handle' do
    user_3 = create(:user, handle: 0)

    fill_in 'invite[handle]', with: user_3.handle

    click_button 'Send Invite'

    expect(page).to have_content("The GitHub user you selected doesn't have an email address associated with their account.")
  end
end
