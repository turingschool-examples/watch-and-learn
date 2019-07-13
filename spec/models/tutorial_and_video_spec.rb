# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'users see tutorials and videos' do
  it 'organizes videos by tutorial in order of position' do
    create_list(:user, 2)

    create_list(:tutorial, 3)

    video1 = create(:video, position: 2, tutorial: Tutorial.all.first)
    video2 = create(:video, position: 1, tutorial: Tutorial.all.first)
    video3 = create(:video, position: 1, tutorial: Tutorial.all.second)
    video4 = create(:video, position: 2, tutorial: Tutorial.all.second)
    video5 = create(:video, position: 3, tutorial: Tutorial.all.third)

    create(:user_video, video: video1, user: User.all.first)
    create(:user_video, video: video2, user: User.all.first)
    create(:user_video, video: video3, user: User.all.first)
    create(:user_video, video: video4, user: User.all.first)
    create(:user_video, video: video5, user: User.all.second)

    tutorials = Tutorial.tutorials_with_videos(User.all.first.id)

    expect(tutorials.count).to eq(2)
    expect(tutorials[0]).to eq(Tutorial.all.first)
    expect(tutorials[1]).to eq(Tutorial.all.second)

    expect(tutorials[0].videos.count).to eq(2)
    expect(tutorials[0].videos[0]).to eq(video2)

    expect(tutorials[1].videos.count).to eq(2)
    expect(tutorials[1].videos[0]).to eq(video3)
  end

  it 'destroys dependent videos' do
    tutorial = create(:tutorial)
    video = create(:video)

    expect(Video.count).to eq(1)
    tutorial.videos << video

    expect { tutorial.destroy }.to change { Video.count }.by(-1)
  end
end
