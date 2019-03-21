require 'rails_helper'

describe 'User' do
  it 'can connect to github via oauth' do
    user = create(:user)

    visit login_path

    fill_in 'session[email]', with: user.email
    fill_in 'session[password]', with: user.password

    click_on 'Log In'

    visit '/dashboard'

    VCR.use_cassette("dashboard") do
      click_on "Connect to Github"
      expect(current_path).to eq(dashboard_path)

      expect(page).to have_css("#Github")
      expect(page).to have_css("#repositories")
      expect(page).to have_css("#followers")
      expect(page).to have_css("#following")
    end
  end
end
