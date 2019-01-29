require 'rails_helper'

describe ' as a user' do
  context 'when I visit dashboard' do
    it 'should see github', :vcr do
      user = create(:user, github_token: ENV['GITHUB_TOKEN'])
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit dashboard_path

      expect(page).to have_css('.github')
      expect(page).to have_content('Github')
    end
    it 'should see repos', :vcr do
      user = create(:user, github_token: ENV['GITHUB_TOKEN'])
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit dashboard_path
      within '.github' do
        expect(page).to have_css('.repository', count: 5)
      end
    end
    it 'should have links', :vcr do
      user = create(:user, github_token: ENV['GITHUB_TOKEN'])
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit dashboard_path

      within '.github' do
        expect(page).to have_css('.name-link')
      end
    end
    it 'should not see github without token', :vcr do
      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit dashboard_path

      expect(page).to_not have_content('Github')
      expect(page).to_not have_css('.github')
    end
  end
end
