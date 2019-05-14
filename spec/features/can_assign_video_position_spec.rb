# frozen_string_literal: true

require 'rails_helper'

describe 'on a tutorial show page' do
  it 'can an assign a video that has no position' do
    tutorial = create(:tutorial)
    vid1 = tutorial.videos.create!(title: 'vid1',
                                   description: 'first video',
                                   video_id: 'first',
                                   position: 0)
    vid2 = tutorial.videos.create!(title: 'vid2',
                                   description: 'second video',
                                   video_id: 'second',
                                   position: nil)

    visit tutorial_path(tutorial)

    within '.tutorials' do
      expect(page).to have_content(vid1.title)
      expect(page).to have_content(vid2.title)
    end
  end
end
