require "rails_helper"

describe 'a registered user can activate their account' do
  it 'activates their account when they are logged in and visit their activation path' do
    user_1 = create(:user, email_activation_status: :unactivated)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)
    visit dashboard_path
    expect(page).to have_content('Status: Unactivated')
    page.driver.submit :patch, account_activation_path(user_1), {}
    expect(current_path).to eq(activation_success_path)
    expect(page).to have_content("Thank you! Your account is now activated.")

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1.reload)
    visit dashboard_path
    expect(page).to have_content("Status: Active")
  end
  it 'redirects to log if you are not logged in as that user' do
    user_1 = create(:user, email_activation_status: :unactivated)
    page.driver.submit :patch, account_activation_path(user_1), {}
    expect(current_path).to eq(login_path)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)
    visit dashboard_path
    expect(page).to have_content('Status: Unactivated')
  end
end
