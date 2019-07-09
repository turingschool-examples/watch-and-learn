# frozen_string_literal: true

require 'rails_helper'

# As a logged in user
# When I visit /dashboard
# Then I should see a section for "Github"
# And under that section I should see another section titled "Followers"
# And I should see list of all followers with their handles linking to their Github profile

describe 'As a logged in user' do
  describe 'Visiting their dashboard' do
    describe 'I see a section for github' do
      it 'shows a list of github followers', :vcr do
        user = create(:user, github_token: ENV['GITHUB_PAT'])

        visit '/'

        click_link 'Sign In'

        fill_in 'Email', with: user.email
        fill_in 'Password', with: user.password

        click_on 'Log In'

        within '#followers' do
          expect(page).to have_content('Followers')

          within '#follower-1' do
            expect(page).to have_link('331smblk', href: 'https://github.com/331smblk')
          end

          within '#follower-2' do
            expect(page).to have_link('Patrick-Duvall', href: 'https://github.com/Patrick-Duvall')
          end

          within '#follower-3' do
            expect(page).to have_link('kylecornelissen', href: 'https://github.com/kylecornelissen')
          end
          
          within '#follower-4' do
            expect(page).to have_link('ryanmillergm', href: 'https://github.com/ryanmillergm')
          end
        end
      end
    end
  end
end
