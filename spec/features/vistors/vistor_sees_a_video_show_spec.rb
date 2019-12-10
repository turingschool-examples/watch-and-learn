require 'rails_helper'

describe 'visitor sees a video show' do
  it 'vistor clicks on a tutorial title from the home page' do
    tutorial = create(:tutorial)
    video = create(:video, tutorial_id: tutorial.id)

    visit '/'

    click_on tutorial.title

    expect(current_path).to eq(tutorial_path(tutorial))
    expect(page).to have_content(video.title)
    expect(page).to have_content(tutorial.title)
  end

  it 'visitor will not see classroom only tutorials' do
    tutorial_1 = create(:tutorial, classroom: true)
    tutorial_2 = create(:tutorial)
    create(:video, tutorial_id: tutorial_1.id)
    create(:video, tutorial_id: tutorial_2.id)

    visit '/'

    expect(page).to_not have_content(tutorial_1.title)
    expect(page).to have_content(tutorial_2.title)
  end
end
