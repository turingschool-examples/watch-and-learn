require 'rails_helper'

describe 'visitor visits video show page' do
  it 'clicks on the bookmark page and is sent to the log in page' do
    tutorial = create(:tutorial)
    video = create(:video, tutorial_id: tutorial.id)

    visit tutorial_path(tutorial)

    expect(page).to have_button('Bookmark', disabled: true)
    # expect('.bookmarks-btn').to have_button(title: "User must login to bookmark videos.")
  end
end
