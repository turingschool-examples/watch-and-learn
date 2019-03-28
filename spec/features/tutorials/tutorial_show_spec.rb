require 'rails_helper'

RSpec.describe "Tutorial show page" do
  it "displays all videos" do
    tut1 = create(:tutorial)
    vid1, vid2 = create_list(:video, 2, tutorial: tut1)

    visit tutorial_path(tut1)

    expect(current_path).to eq(tutorial_path(tut1))
    expect(page).to have_content(tut1.title)
    expect(page).to have_content(vid1.title)
    expect(page).to have_content(vid2.title)
  end

  it "displays correctly when it has no videos" do
    tut1 = create(:tutorial)
    vid1, vid2 = create_list(:video, 2, tutorial: tut1)
    tut2 = create(:tutorial)

    visit tutorial_path(tut2)

    expect(current_path).to eq(tutorial_path(tut2))
    expect(page).to have_content("This tutorial doesn't have any videos yet, but we're working on it!")
  end
end
