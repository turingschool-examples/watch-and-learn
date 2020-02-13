require 'rails_helper'

describe 'As a registered user' do
  it 'I can receive an activation email to activate my account' do

    user = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit dashboard_path

    click_button 'Activate Your Account'
    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content('An email has been sent to your account.')

    visit "/activation/#{user.id}"
    user.reload
    expect(current_path).to eq(dashboard_path)
    expect(user.active).to eq(true)
  end
end
