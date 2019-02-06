require 'rails_helper'

describe 'as a registered user' do
  it 'can send email invites to friends' do
    user = create(:user, token: ENV["GITHUB_API_KEY"])
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit "/dashboard"
    click_on 'Send an Invite'
    expect(current_path).to eq('/invite')

    fill_in :github_handle, with: 'justinmauldin7'
    click_button 'Send Invite'
    expect(current_path).to eq('/dashboard')
    expect(page).to have_content('Successfully sent invite!')
  end

  it 'can not send email invites to friends with no email' do
    user = create(:user, token: ENV["GITHUB_API_KEY"])
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit "/dashboard"
    click_on 'Send an Invite'
    expect(current_path).to eq('/invite')

    fill_in :github_handle, with: 'jpclark6'
    click_button 'Send Invite'
    expect(current_path).to eq('/dashboard')
    expect(page).to have_content("The Github user you selected doesn't have an email address associated with their account.")
  end

  it "can send registration email to non-activated user to register" do
    clear_emails

    user = create(:user, token: ENV["GITHUB_API_KEY"])
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit "/dashboard"
    click_on 'Send an Invite'
    fill_in :github_handle, with: 'justinmauldin7'
    click_button 'Send Invite'

    open_email("justin.mauldin7@gmail.com")
    expect(current_email).to have_content("Hello justinmauldin7,")
    expect(current_email).to have_content("#{ENV['ME']} has invited you to join brownfield-of-dreams. You can create an account")

    current_email.click_link("here")
    expect(current_path).to eq(register_path)
  end
end