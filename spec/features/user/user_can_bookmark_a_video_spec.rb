require 'rails_helper'

describe 'A registered user' do
  it 'can add videos to their bookmarks', :vcr do
    tutorial= create(:tutorial, title: "How to Tie Your Shoes")
    video = create(:video, title: "The Bunny Ears Technique", tutorial: tutorial)
    user = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit tutorial_path(tutorial)

    expect {
      click_on 'Bookmark'
    }.to change { UserVideo.count }.by(1)

    expect(page).to have_content("Bookmark added to your dashboard")
  end

  it "can't add the same bookmark more than once", :vcr do
    tutorial= create(:tutorial)
    video = create(:video, tutorial_id: tutorial.id)
    user = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit tutorial_path(tutorial)

    click_on 'Bookmark'
    expect(page).to have_content("Bookmark added to your dashboard")
    click_on 'Bookmark'
    expect(page).to have_content("Already in your bookmarks")
  end

  it 'displays user bookmarks on the dashboard', :vcr do
    tutorial= create(:tutorial, title: "I Love Pineapple Pizza")
    video = create(:video, title: "The Best Video", tutorial_id: tutorial.id, position: 3)
    video_2 = create(:video, title: "The Best Video V2", tutorial_id: tutorial.id, position: 2)
    video_3 = create(:video, title: "The Best Video V3", tutorial_id: tutorial.id, position: 1)
    user = create(:user)
    user.user_videos.create(video_id: video_3.id)
    user.user_videos.create(video_id: video.id)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit dashboard_path

    expect(page).to have_content("I Love Pineapple Pizza")
    expect(page).to have_content("The Best Video")
    
  end
end
