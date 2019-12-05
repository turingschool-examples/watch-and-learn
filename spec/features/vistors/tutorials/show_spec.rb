require 'rails_helper'

describe 'As a visitor' do
  describe 'when I visit a tutorial show page' do
    it 'visitor can see a list of videos and the tutorial title' do
      tutorial = create(:tutorial)
      video_1 = create(:video, tutorial_id: tutorial.id)
      video_2 = create(:video, tutorial_id: tutorial.id)

      visit tutorial_path(tutorial)

      expect(page).to have_content(tutorial.title)
      expect(page).to have_content(video_1.title)
      expect(page).to have_content(video_2.title)
    end

    it 'visitor cannot view a tutorial show page that is classroom content' do
      tutorial = create(:tutorial, classroom: true)

      visit tutorial_path(tutorial)

      expect(current_path).to eq(root_path)
      expect(page).to have_content('You must login or register to view this page!')
    end
  end
end
