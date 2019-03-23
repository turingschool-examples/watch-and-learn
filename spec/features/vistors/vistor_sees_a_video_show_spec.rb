require 'rails_helper'

describe 'visitor sees a video show' do
  describe 'visitor clicks on a tutorial title from the home page' do
    it 'sees a video if there are videos for the tutorial' do
      tutorial = create(:tutorial)
      video = create(:video, tutorial_id: tutorial.id)

      visit '/'

      click_on tutorial.title

      expect(current_path).to eq(tutorial_path(tutorial))
      expect(page).to have_content(video.title)
      expect(page).to have_content(tutorial.title)
    end

    describe 'if there are no videos for that tutorial' do
      it 'sees a message letting them know there are no videos in that tutorial' do
      tutorial = create(:tutorial)

      visit '/'

      click_on tutorial.title
      expect(current_path).to eq(tutorial_path(tutorial))
      expect(page).to have_content("There are no videos for this tutorial yet.")
      end
    end
  end
end
