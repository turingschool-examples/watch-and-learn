# frozen_string_literal: true

require 'rails_helper'

describe 'As a logged in user' do
  describe 'visiting their dashboard' do
    describe 'I see a section for Following' do
      it 'shows a list of my github following', :vcr do
        user = create(:user, github_token: ENV['GITHUB_PAT'])

        visit '/'

        click_link 'Sign In'

        fill_in 'Email', with: user.email
        fill_in 'Password', with: user.password

        click_on 'Log In'

        within '#following' do
          expect(page).to have_content('Following')

          within '#following-1' do
            expect(page).to have_link('iandouglas', href: 'https://github.com/iandouglas')
          end

          within '#following-2' do
            expect(page).to have_link('331smblk', href: 'https://github.com/331smblk')
          end

          within '#following-3' do
            expect(page).to have_link('Patrick-Duvall', href: 'https://github.com/Patrick-Duvall')
          end

          within '#following-4' do
            expect(page).to have_link('ryanmillergm', href: 'https://github.com/ryanmillergm')
          end
          within '#following-5' do
            expect(page).to have_link('kylecornelissen', href: 'https://github.com/kylecornelissen')
          end
        end
      end
    end
  end
end
