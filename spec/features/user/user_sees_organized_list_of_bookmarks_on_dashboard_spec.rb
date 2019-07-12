# frozen_string_literal: true

require 'rails_helper'

describe 'when a user is logged in and goes to their dashboard' do
  describe 'shows list of all bookmarks under a header' do
    it 'organizes all bookmarks by relevant tutorial and all videos by their position' do
      user1 = create(:user)
      user2 = create(:user)

      tutorial1 = create(:tutorial)
      tutorial2 = create(:tutorial)
      tutorial3 = create(:tutorial)
      create(:tutorial)

      video2 = create(:video, tutorial: tutorial1, position: 2)
      video1 = create(:video, tutorial: tutorial1, position: 1)
      video3 = create(:video, tutorial: tutorial2, position: 1)
      video4 = create(:video, tutorial: tutorial3, position: 1)

      create(:user_video, video: video1, user: user1)
      create(:user_video, video: video2, user: user1)
      create(:user_video, video: video3, user: user1)
      create(:user_video, video: video4, user: user1)
      create(:user_video, video: video1, user: user2)

      visit '/'

      click_on 'Sign In'

      expect(current_path).to eq(login_path)

      fill_in 'session[email]', with: user1.email
      fill_in 'session[password]', with: user1.password

      click_on 'Log In'

      visit '/dashboard'

      expect(page).to have_css('.bookmarked_segments')

      within '.bookmarked_segments' do
        within '#tutorial-1' do
          within '#video-1' do
            expect(page).to have_content(video1.title)
          end
          within '#video-2' do
            expect(page).to have_content(video2.title)
          end
          expect(page).to_not have_css('#video-3')
        end
      end
    end
  end
end
