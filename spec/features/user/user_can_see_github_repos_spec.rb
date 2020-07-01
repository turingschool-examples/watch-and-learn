require 'rails_helper'

describe 'User' do
  context 'As a logged in user' do
    before do
      user = create(:user)

      visit '/'

      click_on "Sign In"

      fill_in 'session[email]', with: user.email
      fill_in 'session[password]', with: user.password

      click_on 'Log In'
    end

    context 'When I visit /dashboard' do
      before do
        visit '/dashboard'
      end

      it 'I see a section for Github' do
        expect(page).to have_content("Github")
      end

      it 'I see repositories' do
        expect(page).to have_css('.repo', count: 5)
        # expect page to have 5 repos
        # expect repo to have name
        # expect repo to have link
      end

      it 'I see a section for Github followers' do
        expect(page).to have_content("Followers:")
      end



      it 'I see followers' do
        expect(page).to have_css('.follower', count: 3)
        # expect page to have 3 followers
        # expect follower to have name
        # expect follower to have link
      end
    end
  end
end


# As a logged in user
# When I visit /dashboard
# Then I should see a section for "Github"
# And under that section I should see a list of 5 repositories with the name of each Repo linking to the repo on Github
