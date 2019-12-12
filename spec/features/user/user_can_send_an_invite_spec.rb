require 'rails_helper'

describe 'A registered user' do
  before(:each) do
    ActionMailer::Base.deliveries = []
  end
  it 'sees an error message if an invite is sent to an invalid github handle', :vcr do
    user_2 = create(:user, github_token: ENV['GITHUB_TOKEN'])
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_2)

    visit '/dashboard'

    click_button 'Send an Invite'

    expect(current_path).to eq('/invite')

    fill_in 'invite[handle]', with: 'zacisaacson'
    click_on 'Send Invite'

    expect(ActionMailer::Base.deliveries).to eq([])

    expect(current_path).to eq('/dashboard')
    expect(page).to have_content("The GitHub user you selected doesn't have an email address associated with their account.")
  end
end
