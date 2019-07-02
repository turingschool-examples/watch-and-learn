require 'rails_helper'

describe 'Logged in user' do
  it 'can see github repos' do
    user = create(:user, username: 'CosmicSpagetti', github_token: ENV['GITHUB_TOKEN'])

    visit '/'

    click_on 'Sign In'

    fill_in 'session[email]', with: user.email
    fill_in 'session[password]', with: user.password

    click_on 'Log In'

    within '.Github_section' do
      expect(page).to have_content('Github')
      expect(page.all('li').count).to eq(5)
    end
  end

  context 'User has no Github Token' do
    it "Won't see repos on dashboard" do
      user = create(:user)

      visit '/'

      click_on 'Sign In'

      fill_in 'session[email]', with: user.email
      fill_in 'session[password]', with: user.password

      click_on 'Log In'

      within '.Github_section' do
        expect(page).to_not have_content('Github')
      end
    end
  end
end
