require 'rails_helper'

require 'rails_helper'

describe 'User dashboard' do
  it "Users can see their github folowees from their dashboard", :vcr do
    user = create(:user, gh_token: ENV['GITHUB_USER_TOKEN'])

    visit '/'

    click_on 'Sign In'

    fill_in 'session[email]', with: user.email
    fill_in 'session[password]', with: user.password

    click_on 'Log In'

    visit dashboard_path

    expect(page).to have_content("Github Users You Follow")
    expect(page).to have_css('.following')
  end
end
