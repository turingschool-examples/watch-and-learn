require 'rails_helper'

describe 'as a user' do
  before(:each) do
    @user = create(:user)
  end

  it 'should show me a link to send an invite on my dashboard' do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

    visit dashboard_path

    click_button('Send an Invite')

    expect(current_path).to eq(invite_path)
  end

  it 'should show me the flash message when it could send the invite' do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

    visit invite_path

    fill_in "Github handle", with: "plapicola"
    click_button('Send Invite')

    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content('Successfully sent invite!')
  end

  it 'should show me flash message when it could not send the invite' do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

    visit invite_path

    fill_in "Github handle", with: "tymazey"
    click_button('Send Invite')

    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content("The Github user you selected doesn't have an email address associated with their account.")
  end
end
