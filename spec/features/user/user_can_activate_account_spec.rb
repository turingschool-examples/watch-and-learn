require 'rails_helper'

describe 'A registered user' do
  it 'can activate account' do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit '/dashboard'

    expect(page).to have_content('Status: Inactive')

    visit '/users/activation'

    expect(current_path).to eq('/dashboard')

    expect(page).to have_content('Status: Active')
    expect(page).to have_content('Thank you! Your account is now activated.')
  end
end
