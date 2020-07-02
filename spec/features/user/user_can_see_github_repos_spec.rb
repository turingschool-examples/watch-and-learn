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

        within '.repos' do
          expect(page).to have_link('futbol')
          expect(page).to have_link('monster_shop_2003')
          expect(page).to have_link('brownfield-of-dreams')
          expect(page).to have_link('adopt_dont_shop_paired')
          expect(page).to have_link('battleship')
        end
      end

      it 'I see a section for Github followers' do
        expect(page).to have_content("Followers:")
      end

      it 'I see followers' do
        expect(page).to have_css('.follower', count: 3)

        within '.followers' do
          expect(page).to have_link('alex-latham')
          expect(page).to have_link('aperezsantos')
          expect(page).to have_link('zachholcomb')
        end
      end

      it 'I see a section for those the user follows' do
        expect(page).to have_content("Following:")
      end

      it 'I see those Im following' do
        expect(page).to have_css('.following', count: 1)
      end
      it 'I see those Im following' do

        within '.following' do
          expect(page).to have_link('Gallup93')
        end
      end
    end
  end
end


# As a logged in user
# When I visit /dashboard
# Then I should see a section for "Github"
# And under that section I should see a list of 5 repositories with the name of each Repo linking to the repo on Github
