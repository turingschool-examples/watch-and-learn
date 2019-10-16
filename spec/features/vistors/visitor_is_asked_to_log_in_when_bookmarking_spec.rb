# frozen_string_literal: true

require 'rails_helper'

describe 'visitor visits video show page' do
  it 'clicks on the bookmark page and is sent to the log in page' do
    tutorial = create(:tutorial)
    video = create(:video, tutorial_id: tutorial.id)

    visit tutorial_path(tutorial)

    click_on("Please Login to Bookmark")

    expect(page).to have_current_path(login_path, ignore_query: true)
  end
end
