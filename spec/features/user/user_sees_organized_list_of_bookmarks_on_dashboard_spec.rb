# frozen_string_literal: true

require 'rails_helper'

describe 'when a user is logged in and goes to their dashboard' do
  describe 'shows list of all bookmarks under a header' do
    it 'organizes all bookmarks by relevant tutorial and all videos by their position' do
      user_1 = create(:user)
      user_2 = create(:user)

      tutorial_1 = create(:tutorial)
      tutorial_2 = create(:tutorial)
      tutorial_3 = create(:tutorial)
      create(:tutorial)

      video_2 = create(:video, tutorial: tutorial_1, position: 2)
      video_1 = create(:video, tutorial: tutorial_1, position: 1)
      video_3 = create(:video, tutorial: tutorial_2, position: 1)
      video_4 = create(:video, tutorial: tutorial_3, position: 1)

      create(:user_video, video: video_1, user: user_1)
      create(:user_video, video: video_2, user: user_1)
      create(:user_video, video: video_3, user: user_1)
      create(:user_video, video: video_4, user: user_1)
      create(:user_video, video: video_1, user: user_2)

      visit '/'

      click_on 'Sign In'

      expect(current_path).to eq(login_path)

      fill_in 'session[email]', with: user_1.email
      fill_in 'session[password]', with: user_1.password

      click_on 'Log In'

      visit '/dashboard'

      expect(page).to have_css('.bookmarked_segments')

      within '.bookmarked_segments' do
        within '#tutorial-1' do
          within '#video-1' do
            expect(page).to have_content(video_1.title)
          end
          within '#video-2' do
            expect(page).to have_content(video_2.title)
          end
          expect(page).to_not have_css('#video-3')
        end
      end
    end
  end
end
