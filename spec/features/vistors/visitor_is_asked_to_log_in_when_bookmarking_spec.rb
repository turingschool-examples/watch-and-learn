require 'rails_helper'

describe 'visitor visits video show page' do
  it 'clicks on the bookmark button and sees a message to login' do
    tutorial = create(:tutorial)
    video = create(:video, tutorial_id: tutorial.id)

    visit tutorial_path(tutorial)

    click_on 'Bookmark'

    expect(current_path).to eq(tutorial_path(tutorial))
  end
end
