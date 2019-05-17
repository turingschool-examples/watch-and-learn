# frozen_string_literal: true

require 'rails_helper'

describe 'a logged in user, at the dashboard' do
  context 'can see a follower/following has an account' do
    it 'has link to add as friend' do
      VCR.use_cassette('friendships/can_see_friendships1') do
        user = create(:user)
        deonte = User.create!(email: '45864171+djc00p@users.noreply.github.com',
                              first_name: 'Deonte',
                              last_name: 'Cooper',
                              password: 'password',
                              username: 'djc00p',
                              github_token: ENV['Deonte_token'],
                               status: 'active')

        earl = User.create!(email: '34906415+earl-stephens@users.noreply.github.com',
                            first_name: 'Earl',
                            last_name: 'Stephens',
                            password: 'password',
                            username: 'earl-stephens',
                            github_token: ENV['token'])
        allow_any_instance_of(ApplicationController).to receive(:current_user)
          .and_return(earl)

        visit dashboard_path
        # save_and_open_page
        within '#github-followers' do
          expect(page.all('li')[8]).to have_content('djc00p')
          expect(page.all('li')[8]).to have_link('Add as Friend')
        end
      end
    end

    it 'can click on link' do
      VCR.use_cassette('friendships/can_see_friendships2') do
        user = create(:user)
        deonte = User.create!(email: '45864171+djc00p@users.noreply.github.com',
                              first_name: 'Deonte',
                              last_name: 'Cooper',
                              password: 'password',
                              username: 'djc00p',
                              github_token: ENV['Deonte_token'],
                               status: 'active')

        earl = User.create(email: '34906415+earl-stephens@users.noreply.github.com',
                           first_name: 'Earl',
                           last_name: 'Stephens',
                           password: 'password',
                           username: 'earl-stephens',
                           github_token: ENV['token'],
                           status: 'active')
        allow_any_instance_of(ApplicationController).to receive(:current_user)
          .and_return(earl)

        visit dashboard_path

        within '#github-followers' do
          click_link 'Add as Friend'
        end

        expect(current_path).to eq(dashboard_path)
        expect(page).to have_content("Added #{deonte.username} as a Friend")

        within '#github-followers' do
          expect(page.all('li')[8]).to have_content('djc00p')
          expect(page.all('li')[8]).to_not have_link('Add as Friend')
        end
      end
    end

    it 'will not have link to add as friend' do
      VCR.use_cassette('friendships/can_see_friendships3') do
        user = create(:user)
        deonte = User.create(email: '45864171+djc00p@users.noreply.github.com',
                             first_name: 'Deonte',
                             last_name: 'Cooper',
                             password: 'password',
                             username: 'djc00p',
                             github_token: ENV['Deonte_token'])

        earl = User.create(email: '34906415+earl-stephens@users.noreply.github.com',
                           first_name: 'Earl',
                           last_name: 'Stephens',
                           password: 'password',
                           username: 'earl-stephens',
                           github_token: ENV['token'],
                           status: 'active')

        friendship = Friendship.create!(user_id: earl.id, friendship_id: deonte.id)

        allow_any_instance_of(ApplicationController).to receive(:current_user)
          .and_return(earl)

        visit dashboard_path

        within '#github-followers' do
          expect(page.all('li')[8]).to have_content('djc00p')
          expect(page.all('li')[8]).to_not have_link('Add as Friend')
        end
      end
    end

    it 'shows users friends' do
      VCR.use_cassette('friendships/can_see_friendships4') do
        deonte = User.create(email: '45864171+djc00p@users.noreply.github.com',
                             first_name: 'Deonte',
                             last_name: 'Cooper',
                             password: 'password',
                             username: 'djc00p',
                             github_token: ENV['Deonte_token'])

        earl = User.create(email: '34906415+earl-stephens@users.noreply.github.com',
                           first_name: 'Earl',
                           last_name: 'Stephens',
                           password: 'password',
                           username: 'earl-stephens',
                           github_token: ENV['token'],
                           status: 'active')

        friendship = Friendship.create!(user_id: earl.id, friendship_id: deonte.id)

        allow_any_instance_of(ApplicationController).to receive(:current_user)
          .and_return(earl)
        visit dashboard_path

        within '.user_friends' do
          expect(page).to have_content(deonte.first_name.to_s)
          expect(page).to have_content(deonte.last_name.to_s)
        end
      end
    end
  end
end
