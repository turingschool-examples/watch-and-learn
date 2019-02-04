require 'rails_helper'

describe 'As a logged in user' do
  describe 'when I visit the dashboard' do
    it 'should show a list of all bookmarked segments under the Bookmarked Segments section' do
      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      tutorial= create(:tutorial, title: "How to Tie Your Shoes")
      video = create(:video, title: "The Bunny Ears Technique", tutorial: tutorial)
      
      visit tutorial_path(tutorial)
      click_on('Bookmark')
      
      visit dashboard_path
      
      expect(page).to have_content('Bookmarked Segments')
      within('.bookmarked') do
        expect(page).to have_content(video.title)
      end
    end
  end
end