# frozen_string_literal: true

require 'rails_helper'

# As a logged in user
# When I visit /dashboard
# Then I should see a section for "Github"
# And under that section I should see another section titled "Followers"
# And I should see list of all followers with their handles linking to their Github profile

RSpec.describe 'As a logged in user' do
  it "I should see a section for 'Github'" do
    VCR.use_cassette('github/user_can_see_github_followers_spec') do
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
        expect(page).to have_content('Github')
      end
    end
  end

  it "I should see a section for 'Github'" do
    VCR.use_cassette('github/user_can_see_github_followers_spec2') do
      user = User.create!(first_name: 'Earl',
                          last_name: 'Stephens',
                          email: 'sethreader@hotmail.com',
                          password: 'password',
                          username: 'djc00p',
                          github_token: ENV['Deonte_token'])

      allow_any_instance_of(ApplicationController)
        .to receive(:current_user)
        .and_return(user)

      visit dashboard_path

      within '#github-section' do
        expect(page).to have_content('Followers')
        expect(page).to have_link('wipegup')
        expect(page).to have_link('earl-stephens')
      end
    end
  end
end
