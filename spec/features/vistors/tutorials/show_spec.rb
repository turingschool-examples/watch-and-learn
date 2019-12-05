require 'rails_helper'

describe 'As a visitor' do
  describe 'when I visit a tutorial show page' do
    it 'visitor can see a list of videos and the tutorial title' do
      tutorial_1 = create(:tutorial)
      video_1 = create(:video, tutorial_id: tutorial_1.id)
      video_2 = create(:video, tutorial_id: tutorial_1.id)
      
      visit tutorial_path(tutorial_1)
      
      expect(page).to have_content(tutorial_1.title)
      expect(page).to have_content(video_1.title)
      expect(page).to have_content(video_2.title)
    end
    
    it 'visitor cannot view a tutorial show page that is classroom content' do
      tutorial_1 = create(:tutorial, classroom: true)
      tutorial_2 = create(:tutorial)
      video_2 = create(:video, tutorial_id: tutorial_2.id)

      visit tutorial_path(tutorial_1)

      expect(current_path).to eq(root_path)
      expect(page).to have_content('You must login or register to view this page!')

      visit tutorial_path(tutorial_2)

      expect(current_path).to eq(tutorial_path(tutorial_2))
    end
  end
end
