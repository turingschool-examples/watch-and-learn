require 'rails_helper'

describe 'As a registered user' do
  it 'can see list of their followers that are links' do
    user = create(:user)

    visit login_path

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password

    click_on 'Log In'

    within '.github-info' do
      expect(page).to have_content('GitHub')
      within '.github-followers' do
        expect(page).to have_css('.follower-link')
      end
    end
  end
end
