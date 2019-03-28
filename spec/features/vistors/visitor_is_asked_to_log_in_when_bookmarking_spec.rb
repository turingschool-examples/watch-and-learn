# frozen_string_literal: true

require 'rails_helper'

describe 'visitor visits video show page' do
  it 'clicks on the bookmark page and is sent to the log in page' do
    tutorial = create(:tutorial)
    video = create(:video, tutorial_id: tutorial.id)

    visit tutorial_path(tutorial)
    expect(page.has_content?('User must login to bookmark videos')).to be(false)

    click_link 'Bookmark'
    expect(page.has_current_path?(tutorial_path(tutorial))).to be(true)
    expect(page.has_content?('User must login to bookmark videos')).to be(true)
  end
end
