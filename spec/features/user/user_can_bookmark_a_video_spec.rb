require 'rails_helper'

describe 'A registered user' do
  it 'can add videos to their bookmarks' do
    tutorial= create(:tutorial, title: "How to Tie Your Shoes", classroom: false)
    video = create(:video, title: "The Bunny Ears Technique", tutorial: tutorial)
    user = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit tutorial_path(tutorial)

    expect {
      click_on 'Bookmark'
    }.to change { UserVideo.count }.by(1)

    expect(page).to have_content("Bookmark added to your dashboard")
  end

  it "can't add the same bookmark more than once" do
    tutorial= create(:tutorial, classroom: false)
    video = create(:video, tutorial_id: tutorial.id)
    user = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit tutorial_path(tutorial)

    click_on 'Bookmark'
    expect(page).to have_content("Bookmark added to your dashboard")
    click_on 'Bookmark'
    expect(page).to have_content("Already in your bookmarks")
  end
  it "can see a list of all bookmarked segments", :vcr do
    tutorial= create(:tutorial, title: "How to Tie Your Shoes", classroom: false)
    video = create(:video, title: "The Bunny Ears Technique", tutorial: tutorial)
    tutorial_2= create(:tutorial, title: "How to Not Tie Your Shoes")
    video_2 = create(:video, title: "The Fish Ears Technique", tutorial: tutorial_2)


    user = create(:user, github_token: ENV["GITHUB_TOKEN"])
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    visit tutorial_path(tutorial)

    click_on 'Bookmark'

    visit '/dashboard'

    expect(page).to have_content("Bookmarked Videos")

    within '.bookmarked_videos' do
      expect(page).to have_content(video.title)
      expect(page).to_not have_content(video_2.title)
    end
  end
end
