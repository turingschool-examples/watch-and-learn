# frozen_string_literal: true

require 'rails_helper'

describe 'User sees functional button to add a friend' do
  it 'shows sad path message for adding invalid user' do
    VCR.use_cassette('features/user/adds_friends') do
      u1 = create(:user, github_token: ENV['GITHUB_TOKEN_J'])
      u2 = create(:user, github_token: ENV['GITHUB_TOKEN_M'], uid: 28_820_023)
      GithubUser.new(name: 'name', url: 'https://git.com/', uid: 28_820_023)

      allow_any_instance_of(ApplicationController)
        .to receive(:current_user).and_return(u1)
      visit '/dashboard'

      u2.destroy

      within('#follower-6') do
        click_button 'Add as Friend'
      end

      expect(page).to_not have_content('Successfully created friendship')
      expect(page).to have_content('Unable to add friend')
    end
  end
end
