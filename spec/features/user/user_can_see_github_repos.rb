require 'rails_helper'

describe 'As a registered user' do
  it 'can see list of 5 repos that are links' do
    user = create(:user)

    visit login_path

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password

    click_on 'Log In'

    expect(page).to have_content('GitHub')
    within '.github-info' do
      within '.github-repos' do
        expect(page).to have_css('.repo-link')
      end
    end
  end
end
