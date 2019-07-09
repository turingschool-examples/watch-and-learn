# frozen_string_literal: true

require 'rails_helper'

describe 'friendships can be forged between authenticated users' do
  describe 'as a authenticated user looking to add a friend' do
    it 'shows button for authenticated users in the system' do
      VCR.use_cassette('features/user/adds_friends') do
        user_1 = create(:user, email: 'user_1@example.com', first_name: 'name_1', password: 'password', role: :default, github_token: ENV['GITHUB_TOKEN_J'], uid: 10)
        create(:user, email: 'user_2@example.com', first_name: 'name_2', password: 'password', role: :default, github_token: ENV['GITHUB_TOKEN_M'], uid: 28_820_023)
        GithubUser.new(name: 'name', url: 'https://github.com/', uid: 28_820_023)

        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)
        visit '/dashboard'

        within('.friends') do
          expect(page).to have_content('No Friends Found')
          expect(page).to_not have_css('#friend-1')
        end

        within('#following-1') do
          expect(page).to have_button('Add as Friend')
        end

        within('#following-2') do
          expect(page).to_not have_button('Add as Friend')
        end

        within('#follower-1') do
          expect(page).to_not have_button('Add as Friend')
        end

        within('#follower-6') do
          expect(page).to have_button('Add as Friend')
          click_button # Authenticates with Github
          expect(page).to_not have_button('Add as Friend')
        end

        expect(page).to have_content('Successfully created friendship')

        within('.friends') do
          expect(page).to_not have_content('No Friends Found')
          expect(page).to have_css('#friend-1')
          expect(page).to have_content('name_2')
        end
      end
    end
  end
end
