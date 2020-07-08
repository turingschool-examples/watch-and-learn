require 'rails_helper'

describe 'A registered user' do
  it 'can add videos to their bookmarks' do
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

  it "can't add the same bookmark more than once" do
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
   it "should display bookmarked segments" do
     tutorial= create(:tutorial)
     tutorial2= create(:tutorial)
     tutorial3= create(:tutorial)
     user = create(:user)
     video = create(:video, tutorial_id: tutorial.id, position: "1")
     video2 = create(:video, tutorial_id: tutorial2.id, position: "1")
     video3 = create(:video, tutorial_id: tutorial3.id, position: "1")
     video4 = create(:video, tutorial_id: tutorial.id, position: "1")

     create(:user_video, video_id: video.id, user_id: user.id)
     create(:user_video, video_id: video2.id, user_id: user.id)
     create(:user_video, video_id: video3.id, user_id: user.id)
     create(:user_video, video_id: video4.id, user_id: user.id)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)


    visit dashboard_path


    expect(page).to have_css(".bookmarks")
    expect(page).to have_content(tutorial.title)
    expect(page).to have_content(video.title)
    expect(page).to have_content(video4.title)
    expect(page).to have_content(tutorial2.title)
    expect(page).to have_content(video2.title)
    expect(page).to have_content(tutorial3.title)
    expect(page).to have_content(video3.title)



  end
end
