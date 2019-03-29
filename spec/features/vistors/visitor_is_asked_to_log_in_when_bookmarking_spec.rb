# frozen_string_literal: true

require 'rails_helper'

describe 'visitor visits video show page' do
  it 'clicks on the bookmark page and is sent to the log in page' do
    tutorial = create(:tutorial)
    create(:video, tutorial_id: tutorial.id)

    visit tutorial_path(tutorial)
    expect(page.has_content?('User must login to bookmark videos')).to be(false)

    click_link 'Bookmark'
    expect(page.has_content?('User must login to bookmark videos')).to be(true)
    expect(current_path).to eq(tutorial_path(tutorial))
  end
end
