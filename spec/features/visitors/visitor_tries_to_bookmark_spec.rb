require 'rails_helper'

describe 'visitor visits video show page' do
  it 'clicks on the bookmark page and sees a flash message' do
    tutorial = create(:tutorial)
    video = create(:video, tutorial_id: tutorial.id)

    visit tutorial_path(tutorial)

    expect(page).to have_button('Bookmark', disabled: false)

    click_button 'Bookmark'

    expect(current_path).to eq(tutorial_path(tutorial))

    expect(UserVideo.all.count).to eq(0)

    ## Will also show a flash message "User must login to bookmark videos."
    ## and button will be disabled.
  end
end
