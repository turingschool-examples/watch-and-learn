# frozen_string_literal: true

require 'rails_helper'

# As a logged in user
# When I visit /dashboard
# Then I should see a section for "Github"
# And under that section I should see a list of 5 repositories with the name of each Repo linking to the repo on Github

describe 'As a logged in user' do
  describe 'visiting their dashboard' do
    describe 'I see a section for github' do
      it 'shows a list of my repos' do
        user = create(:user, github_token: ENV['GITHUB_PAT'])

        visit '/'

        click_link 'Sign In'

        fill_in 'Email', with: user.email
        fill_in 'Password', with: user.password

        click_on 'Log In'

        within '#github' do
          expect(page).to have_content('GitHub')
          expect(page).to have_all_of_selectors('#repo-1', '#repo-2', '#repo-3', '#repo-4', '#repo-5')
        end
      end
    end
  end
end
