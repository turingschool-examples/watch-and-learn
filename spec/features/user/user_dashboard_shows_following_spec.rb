require 'rails_helper'

describe 'Logged in user' do
  it 'can see who they follow on github' do
    user = create(:user, username: 'CosmicSpagetti', github_token: ENV['BILLY_GITHUB_TOKEN'])

    visit '/'

    click_on 'Sign In'

    fill_in 'session[email]', with: user.email
    fill_in 'session[password]', with: user.password

    click_on 'Log In'

    within '.Github_following_section' do
      expect(page).to have_content('Following')
      expect(page.all('li').count).to eq(3)
      expect(page).to have_link("earl-stephens")
    end
  end
end
