require 'rails_helper'

describe 'visitor visits video show page' do
  it 'clicks on the bookmark page and gets a flash message' do
    tutorial = create(:tutorial)
    video = create(:video, tutorial_id: tutorial.id)

    visit tutorial_path(tutorial)

    click_on 'Bookmark'

    expect(current_path).to eq(tutorial_path(tutorial))
    within('.flash-message') do
      expect(page).to have_content('Please login or register to bookmark videos')
    end
  end
end