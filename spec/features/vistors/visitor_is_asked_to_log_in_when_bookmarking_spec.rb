require 'rails_helper'

describe 'visitor visits video show page' do
  it 'clicks on the bookmark page, shows error message to login' do
    tutorial = create(:tutorial)
    create(:video, tutorial_id: tutorial.id)

    visit tutorial_path(tutorial)

    click_on 'Bookmark'

    expect(current_path).to eq(tutorial_path(tutorial))
    expect(page).to have_content("User must login to bookmark videos.")
  end
end
