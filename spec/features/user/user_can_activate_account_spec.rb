require 'rails_helper'

RSpec.describe 'As a user' do
  it 'I can activate my account' do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit dashboard_path

    expect(page).to have_content('Status: Inactive')

    visit '/user/activation'

    expect(current_path).to eq dashboard_path

    expect(page).to have_content('Status: Active')
    expect(page).to have_content('Thank you! Your account is now activated.')
  end
end
