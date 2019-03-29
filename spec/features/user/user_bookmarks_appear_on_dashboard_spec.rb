# frozen_string_literal: true

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
        expect(page.has_link?(count: 5)).to be(true)
        click_link(videos[0].title)
      end

      expect(page.has_current_path?(tutorial_path(videos[0].tutorial))).to be(true)
    end
  end
end
