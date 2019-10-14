# frozen_string_literal: true

require 'rails_helper'

describe 'A registered user' do
  it 'can add videos to their bookmarks' do
    tutorial = create(:tutorial, title: 'How to Tie Your Shoes')
    video = create(:video, title: 'The Bunny Ears Technique', tutorial: tutorial)
    user = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit tutorial_path(tutorial)

    expect do
      click_on 'Bookmark'
    end.to change { UserVideo.count }.by(1)

    expect(page).to have_content('Bookmark added to your dashboard')
  end

  it "can't add the same bookmark more than once" do
    tutorial = create(:tutorial)
    video = create(:video, tutorial_id: tutorial.id)
    user = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit tutorial_path(tutorial)

    click_on 'Bookmark'
    expect(page).to have_content('Bookmark added to your dashboard')
    click_on 'Bookmark'
    expect(page).to have_content('Already in your bookmarks')
  end

  it "shows a list of all bookmarked segments under the Bookmarked Segments section, organized by which tutorial they're a part of and ordered by their position" do
    tutorial = create(:tutorial)
    tutorial_2 = create(:tutorial)
    tutorial_3 = create(:tutorial)
    video = create(:video, tutorial_id: tutorial.id, position: 1)
    video_2 = create(:video, tutorial_id: tutorial_2.id, position: 1)
    video_3 = create(:video, tutorial_id: tutorial_3.id, position: 2)
    video_4 = create(:video, tutorial_id: tutorial_3.id, position: 1)
    user = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit "/tutorials/#{tutorial.id}?video_id=#{video.id}"
    click_on 'Bookmark'

    visit "/tutorials/#{tutorial_2.id}?video_id=#{video_2.id}"
    click_on 'Bookmark'

    visit "/tutorials/#{tutorial_3.id}?video_id=#{video_3.id}"
    click_on 'Bookmark'
    visit "/tutorials/#{tutorial_3.id}?video_id=#{video_4.id}"
    click_on 'Bookmark'

    visit dashboard_path

    expect(page).to have_content(video.title)
    expect(page).to have_content(video_2.title)
    expect(page).to have_content(video_3.title)
    expect(page).to have_content(video_4.title)

    expected_order = "Tutorial #{tutorial.id}\n#{video.title}\nTutorial #{tutorial_2.id}\n#{video_2.title}\nTutorial #{tutorial_3.id}\n#{video_4.title} #{video_3.title}"

    expect(page).to have_content(expected_order)
  end
end
