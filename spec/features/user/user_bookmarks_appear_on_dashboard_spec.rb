require 'rails_helper'

describe 'A registered user without a github token' do
  context 'visiting /dashboard' do
    it 'can see a list of all their bookmarked segments' do
      user = create(:user)
      videos = create_list(:video, 5)
      videos.each do |video|
        create(:user_video, user: user, video: video)
      end

      login_as(user)
      visit dashboard_path

      within '.bookmarks' do
        expect(page).to have_link(count: 5)
        click_link(videos[0].title)
      end

      expect(current_path).to eq(tutorial_path(videos[0].tutorial))
    end
  end
end
