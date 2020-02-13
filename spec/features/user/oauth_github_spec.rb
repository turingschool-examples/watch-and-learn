# frozen_string_literal: true

require 'rails_helper'

describe 'connect to github using omniauth' do
  it 'connect to githun link on dashboard page' do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    VCR.use_cassette('connect_to_github') do
      OmniAuth.config.test_mode = true
      OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new('provider' => 'github',
                                                                  'uid' => '29346170',
                                                                  'info' =>
        { 'nickname' => 'hale4029',
          'email' => 'harrison483@gmail.com',
          'name' => 'Harrison',
          'image' => 'https://avatars2.githubusercontent.com/u/29346170?v=4',
          'urls' => { 'GitHub' => 'https://github.com/hale4029', 'Blog' => '' } },
                                                                  'credentials' => { 'token' => (ENV['GITHUB_ACCESS_TOKEN']).to_s, 'expires' => false })

      visit '/dashboard'

      expect(page).to_not have_content('Github Repos')
      expect(page).to_not have_css('#repos')
      expect(page).to_not have_content('Github Following')

      click_link 'Connect to Github'

      expect(page).to have_content('Github Repos')
      within '#repos' do
        expect(page).to have_css('#dot', count: 5)
      end
      expect(page).to have_content('Github Following')
    end
  end
end
