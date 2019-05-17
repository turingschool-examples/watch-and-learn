# frozen_string_literal: true

require 'rails_helper'

describe 'when logged in user visits root path' do
  it 'he can see github repos' do
    VCR.use_cassette('github/can_see_github_info1') do
      user = User.create!(first_name: 'Earl',
                          last_name: 'Stephens',
                          email: 'sethreader@hotmail.com',
                          password: 'password',
                          username: 'earl-stephens',
                          github_token: ENV['token'])

      allow_any_instance_of(ApplicationController)
        .to receive(:current_user)
        .and_return(user)

      visit dashboard_path

      within '#github-section' do
        expect(page).to have_link
      end
    end
  end
end

describe 'when another logged in user visits root path' do
  it 'tests for different user' do
    VCR.use_cassette('github/can_see_github_info2') do
      user = User.create!(first_name: 'Deonte',
                          last_name: 'Cooper',
                          email: '45864171+djc00p@users.noreply.github.com',
                          password: 'password',
                          username: 'djc00p',
                          github_token: ENV['Deonte_token'])

      allow_any_instance_of(ApplicationController)
        .to receive(:current_user)
        .and_return(user)

      visit dashboard_path

      within '#github-section' do
        expect(page).to have_link
      end
    end
  end
end

describe 'when logged in user visits root path without a token' do
  it 'he cannot see github repos if he doesnt have a token' do
    VCR.use_cassette('github/can_see_github_info3') do
      user = User.create!(first_name: 'Earl',
                          last_name: 'Stephens',
                          email: 'sethreader@hotmail.com',
                          password: 'password',
                          username: 'earl-stephens')

      allow_any_instance_of(ApplicationController)
        .to receive(:current_user)
        .and_return(user)

      visit dashboard_path

      within '#github-section' do
        expect(page).to_not have_content('Github')
      end
    end
  end
end

describe 'logged in user sees the people he follows on github' do
  it 'from the github api' do
    VCR.use_cassette('github/can_see_github_info4') do
      user = User.create!(first_name: 'Earl',
                          last_name: 'Stephens',
                          email: '34906415+earl-stephens@users.noreply.github.com',
                          password: 'password',
                          username: 'earl-stephens',
                          github_token: ENV['token'])

      allow_any_instance_of(ApplicationController)
        .to receive(:current_user)
        .and_return(user)

      visit dashboard_path

      within '#github-section' do
        expect(page).to have_link('pschlatt')
        expect(page).to have_link('djc00p')
      end
    end
  end
end
