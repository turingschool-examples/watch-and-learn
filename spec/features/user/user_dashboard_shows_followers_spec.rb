require 'rails_helper'

describe 'Logged in user' do
  it 'can see github followers' do
    user = create(:user, username: 'CosmicSpagetti', github_token: ENV['BILLY_GITHUB_TOKEN'])

    visit '/'

    click_on 'Sign In'

    fill_in 'session[email]', with: user.email
    fill_in 'session[password]', with: user.password

    click_on 'Log In'

    within '.Github_followers_section' do
      expect(page).to have_content('Followers')
      expect(page.all('li').count).to eq(3)
      # expect(page).to have_content("earl-stephens")
      expect(page).to have_link("earl-stephens")
    end
  end
end
