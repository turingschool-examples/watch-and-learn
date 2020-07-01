require 'rails_helper'

describe 'As a registered user' do
  describe 'When I visit the dashboard' do
    it 'I see a list of five of my github repos' do
      user = create(:user, token:  ENV["GITHUB_API_TOKEN"])

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit '/dashboard'

      within('#github-repos') do
        expect(page).to have_css(".user-repo", count: 5)
      end
    end

    it 'Project names link to the repo on github' do

    end

    it 'Does not display a github section if the user does not have a token' do

    end
  end
end
