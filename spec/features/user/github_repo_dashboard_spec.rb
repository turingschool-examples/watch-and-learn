# frozen_string_literal: true

require 'rails_helper'

describe '/dashboard page' do
  # describe '/dashboard page', :vcr do
  it 'show repos - happy' do
    user = create(:user, token: ENV['GITHUB_ACCESS_TOKEN'])
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    VCR.use_cassette('repos_happy') do
      visit '/dashboard'

      expect(page).to have_content('Github Repos')
      within '#repos' do
        expect(page).to have_css('#dot', count: 5)
      end
    end
  end

  it 'show repos - sad' do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit '/dashboard'

    expect(page).to_not have_content('Github Repos')
    expect(page).to_not have_css('#repos')
  end

  it 'shows followers name and a link to their homepage' do
    user = create(:user, token: ENV['GITHUB_ACCESS_TOKEN'])
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    VCR.use_cassette('followers') do
      visit '/dashboard'
      expect(page).to have_content('Github Followers')
    end
  end

  it 'shows following name and a link to their homepage' do
    user = create(:user, token: ENV['GITHUB_ACCESS_TOKEN'])
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    VCR.use_cassette('following') do
      visit '/dashboard'
      expect(page).to have_content('Github Following')
    end
  end

  it 'see friendship button/link for people in database that follow me' do
    user = create(:user, github_id: '29346170', token: ENV['GITHUB_ACCESS_TOKEN'])
    user_in_database = create(:user, first_name: 'David', github_id: '50917634')
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    VCR.use_cassette('add_friend') do
      visit '/dashboard'

      expect(page).to have_content('Github Following')
      expect(page).to have_css('#add_friend_followers', count: 1)
      expect(page).to have_css('#add_friend_following', count: 1)

      within '#followees' do
        expect(page).to_not have_content('David')
      end

      within '#add_friend_followers' do
        click_on 'Add Friend'
      end

      expect(current_path).to eq(dashboard_path)
      within '#followees' do
        expect(page).to have_content('David')
      end

      expect(page).to_not have_css('#add_friend_followers')
    end
  end
end
