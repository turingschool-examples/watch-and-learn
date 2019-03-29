# frozen_string_literal: true

require 'rails_helper'

describe 'visitor sees a video show' do
  it 'vistor clicks on a tutorial title from the home page' do
    tutorial = create(:tutorial)
    video = create(:video, tutorial_id: tutorial.id)

    visit '/'

    click_on tutorial.title

    expect(page.has_current_path?(tutorial_path(tutorial))).to be(true)
    expect(page.has_content?(video.title)).to be(true)
    expect(page.has_content?(tutorial.title)).to be(true)
  end
end
