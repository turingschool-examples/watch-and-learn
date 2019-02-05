require 'rails_helper'

describe 'As a Visitor' do
  describe 'visitor sees a video show' do
    it 'vistor clicks on a tutorial title from the home page' do
      tutorial = create(:tutorial)
      video = create(:video, tutorial_id: tutorial.id)

      visit '/'

      click_on tutorial.title

      expect(current_path).to eq(tutorial_path(tutorial))
      expect(page).to have_content(video.title)
      expect(page).to have_content(tutorial.title)
    end
  end

  describe 'when they visit a tutorial show page' do
    it 'only shows valid tutorials' do
      tutorial = create(:tutorial)

      visit '/'

      click_on tutorial.title

      expect(current_path).to eq(root_path)
      expect(page).to have_content("The tutorial you selected has no videos.")
    end
  end
end
