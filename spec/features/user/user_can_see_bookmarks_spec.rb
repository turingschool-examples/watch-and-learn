require 'rails_helper'

describe 'A registered user' do
  it 'can see bookmarks on their dashboard' do
    tutorial = create(:tutorial, title: "How to Tie Your Shoes")
    tutorial_2 = create(:tutorial, title: "Something Else Entirely")
    bookmark = create(:video, title: "The Bunny Ears Technique", tutorial: tutorial, position: 1)
    video = create(:video, title: "Another Way to Tie Your Shoes", tutorial: tutorial, position: 2)
    bookmark_2 = create(:video, title: "Twiddling Your Thumbs", tutorial: tutorial_2, position: 2)
    bookmark_3 = create(:video, title: "Desk Finger Drumming", tutorial: tutorial_2, position: 1)
    user = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit tutorial_path(tutorial)
    click_button('Bookmark')

    visit tutorial_path(tutorial_2)
    click_button('Bookmark')
    click_link(bookmark_2.title)
    click_button('Bookmark')

    expect(UserVideo.count).to eq(3)

    visit dashboard_path
    within(".tutorial-#{tutorial.id}-bookmarks") do
      expect(page).to have_content(tutorial.title)
      expect(page).to have_link(bookmark.title)
      expect(page).to_not have_link(video.title)
      expect(page).to_not have_link(bookmark_2.title)
      expect(page).to_not have_link(bookmark_3.title)
    end

    within(".tutorial-#{tutorial_2.id}-bookmarks") do
      expect(page).to have_content(tutorial_2.title)
      expect(page).to have_link(bookmark_3.title)
      expect(page).to have_link(bookmark_2.title)
      expect(bookmark_3.title).to appear_before(bookmark_2.title)
      expect(page).to_not have_link(bookmark.title)
    end
  end
end
