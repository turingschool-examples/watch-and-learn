# frozen_string_literal: true

require 'rails_helper'

describe 'on the user show page' do
  it 'shows bookmarked videos' do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    tutorial1 = create(:tutorial)
    tutorial2 = create(:tutorial)
    video1 = create(:video, tutorial_id: tutorial1.id)
    video2 = create(:video, tutorial_id: tutorial2.id, position: 3)
    video3 = create(:video, tutorial_id: tutorial2.id, position: 1)
    video4 = create(:video, tutorial_id: tutorial1.id, position: 2)
    video5 = create(:video, tutorial_id: tutorial1.id, position: 2)
    user_video1 = UserVideo.create!(user_id: user.id, video_id: video1.id)
    user_video2 = UserVideo.create!(user_id: user.id, video_id: video2.id)
    user_video3 = UserVideo.create!(user_id: user.id, video_id: video3.id)
    user_video4 = UserVideo.create!(user_id: user.id, video_id: video4.id)

    visit dashboard_path

    within '.bookmarked_segment' do
      expect(page).to have_content(tutorial1.title)
      expect(page).to have_content(video1.title)
      expect(page).to have_content(video4.title)
      expect(page).to have_content(video4.title)
      expect(page).to_not have_content(video5.title)
    end
  end
end
