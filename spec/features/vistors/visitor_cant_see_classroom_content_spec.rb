require 'rails_helper'

describe 'visitor visits root page' do
  it 'visitor doesnt see classroom content' do
    tutorial = create(:tutorial, classroom: true)
    tutorial2 = create(:tutorial)
    video = create(:video, tutorial_id: tutorial.id)
    video = create(:video, tutorial_id: tutorial2.id)

    visit "/"

    expect(page).to have_content(tutorial2.title)
    expect(page).to_not have_content(tutorial.title)
  end
end
