require 'rails_helper'

RSpec.describe 'As a user' do
  context 'When I visit my profile page', :vcr do
    it 'shows a list of repos' do
      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit dashboard_path

      within '.github' do
        expect(page).to have_content("Your Repositories")
        expect(page).to have_link("2win_playlist")
        expect(page).to have_link("activerecord-obstacle-course")
        expect(page.all('li').count).to eq(5)
      end
    end

  end
end
