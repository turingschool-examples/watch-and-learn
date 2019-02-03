require 'rails_helper'

describe 'As a logged in user' do
  describe 'on dashboard page' do
    it 'should see link Add as Friend in followers', :vcr do
      user = create(:user, github_token: ENV['GITHUB_TOKEN'])
      follower = create(:user, github_token: 'pizza', uid: '22285337')

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit dashboard_path

      within '.github' do
        expect(page).to have_link('Add as Friend', count: 1)
        within first('.follower') do
          expect(page).to have_link('Add as Friend')
        end
      end
    end
  end
end
