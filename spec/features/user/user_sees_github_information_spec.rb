# frozen_string_literal: true

require 'rails_helper'

describe 'A registered user' do
  it 'I can see list of five github repos with name of each repo linked to repo on github if I have a github_token', :vcr do
    json_response = File.open('./fixtures/github_repo_data.json')
    stub_request(:get, 'https://api.github.com/user/repos').to_return(status: 200, body: json_response)

    user = create(:user, github_token: ENV["GITHUB_API_KEY"])

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit '/dashboard'

    expect(page).to have_content('Github Section')

    within('.github') do
      expect(page).to have_css('.repo_name_and_link')
    end
  end

  it 'I can see list of my github followers with their names as links to their profiles', :vcr do
    json_response = File.open('./fixtures/github_followers_data.json')
    stub_request(:get, 'http://api.github.com/user/followers').to_return(status: 200, body: json_response)

    user = create(:user, github_token: ENV["GITHUB_API_KEY"])

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit '/dashboard'

    expect(page).to have_content('Github Section')

    within('.github') do
      expect(page).to have_css('.followers_name_and_link')
    end
  end

    it 'I can see list of accounts that I follow with name of each account I follow linked to their account page on github if I have a github_token', :vcr do
      json_response = File.open('./fixtures/github_following_data.json')
      stub_request(:get, 'https://api.github.com/user/following').to_return(status: 200, body: json_response)

      user = create(:user, github_token: ENV["GITHUB_API_KEY"])

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit '/dashboard'

      expect(page).to have_content('Github Section')

      within('.github') do
        expect(page).to have_css('.following_name_and_link')
      end
    end

  it 'I cannot see list of five github repos if I do not have a github_token', :vcr do
    json_response = File.open('./fixtures/github_repo_data.json')
    stub_request(:get, 'https://api.github.com/user/repos').to_return(status: 200, body: json_response)

    user = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit '/dashboard'

    expect(page).to_not have_content('Github Section')

    expect(page).to_not have_css('.github')
  end
end

# As a logged in user
# When I visit /dashboard
# Then I should see a section for "Github"
# And under that section I should see a list of 5 repositories with the name of each Repo linking to the repo on Github
