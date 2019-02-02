require "rails_helper"

describe 'a registered user can activate their account' do
  it 'activates their account when they are logged in and visit their activation path' do
    user_1 = create(:user, status: :unactivated)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)
    visit dashboard_path
    expect(page).to have_content('Status: Unactivated')
    visit account_activation_path(user)
    expect(current_path).to eq(activation_success_path)
    expect(page).to have_content("Thank you! Your account is now activated.")
    visit dashboard_path
    expect(page).to have_content("Status: Active")
  end
end
