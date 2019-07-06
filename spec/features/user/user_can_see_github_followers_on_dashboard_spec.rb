# frozen_string_literal: true

require 'rails_helper'

# As a logged in user
# When I visit /dashboard
# Then I should see a section for "Github"
# And under that section I should see another section titled "Followers"
# And I should see list of all followers with their handles linking to their Github profile

describe 'As a logged in user' do
  describe 'Visiting the dashboard' do
    describe 'I see a section for github' do
      it 'shows a list of github followers' do
        user = create(:user, github_token: ENV['GITHUB_PAT'])

        visit '/'

        click_link 'Sign In'

        fill_in 'Email', with: user.email
        fill_in 'Password', with: user.password

        click_on 'Log In'

        within '#followers' do
          expect(page).to have_content('Followers')
          expect(page).to have_all_of_selectors('#follower-1', '#follower-2', '#follower-3', '#follower-4')
        end
      end
    end
  end
end
