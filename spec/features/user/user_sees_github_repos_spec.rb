# frozen_string_literal: true

require 'rails_helper'

# As a logged in user
# When I visit /dashboard
# Then I should see a section for "Github"
# And under that section I should see a list
# of 5 repositories with the name of each Repo
# linking to the repo on Github

describe 'when logged in user visits root path' do
  it 'he can see github repos' do
    user = User.create!(first_name: 'Earl', last_name: 'Stephens', email: 'sethreader@hotmail.com', password: 'password', username: 'earl-stephens', github_token: '104974a366a77abc1140f41dba805667b3808380')

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit dashboard_path

    within '#github-section' do
      expect(page).to have_link
    end
  end

  it 'tests for different user' do
    user = User.create!(first_name: 'Deonte', last_name: 'Cooper', email: '45864171+djc00p@users.noreply.github.com', password: 'password', username: 'djc00p', github_token: '76d70e33d2242b19fd15874deaeec51c1b6a9231')

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit dashboard_path
    # save_and_open_page
    within '#github-section' do
      expect(page).to have_link
    end
  end

  it 'he cannot see github repos if he doesnt have a token' do
    user = User.create!(first_name: 'Earl', last_name: 'Stephens', email: 'sethreader@hotmail.com', password: 'password', username: 'earl-stephens') # , github_token: "104974a366a77abc1140f41dba805667b3808380")

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit dashboard_path

    within '#github-section' do
      expect(page).to_not have_content('github.com')
    end
  end
end
