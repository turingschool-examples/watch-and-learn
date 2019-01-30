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

  it 'visitor does not see tutorials that have a classroom label' do
    tutorial = create(:tutorial, classroom: false)
    tutorial_2 = create(:tutorial, classroom: true)
    video = create(:video, tutorial_id: tutorial.id)

    visit '/'

    expect(page).to have_content(tutorial.title)
    expect(page).to_not have_content(tutorial_2.title)

    click_on tutorial.title

    expect(current_path).to eq(tutorial_path(tutorial))
    expect(page).to have_content(video.title)
    expect(page).to have_content(tutorial.title)
  end

  it 'visitor can not see a tutorial that is labeled classroom' do
    tutorial = create(:tutorial, classroom: true)
    video = create(:video, tutorial_id: tutorial.id)

    visit tutorial_path(tutorial)

    expect(current_path).to eq(root_path)
  end
end
