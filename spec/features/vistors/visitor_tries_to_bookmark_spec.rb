require 'rails_helper'

describe 'visitor visits video show page' do
  it 'clicks on the bookmark page and sees a flash message' do
    tutorial = create(:tutorial)
    video = create(:video, tutorial_id: tutorial.id)

    visit tutorial_path(tutorial)

    click_button 'Bookmark'

    expect(current_path).to eq(tutorial_path(tutorial))
  end
end
