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

  it 'shows added bookmarks on the user dashboard' do
    tutorial= create(:tutorial)
    video_1 = create(:video, tutorial_id: tutorial.id, position: 2)
    video_2 = create(:video, tutorial_id: tutorial.id, position: 1)
    user = create(:user)
    user_video = create(:user_video, user: user, video: video_1)
    user_video = create(:user_video, user: user, video: video_2)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit dashboard_path
    expect(page).to have_content("Bookmarked Segments")
    within '#bookmarked_segments' do
      expect(page).to have_content(tutorial.title)
      within "#tutorial-#{tutorial.id}" do
        expect(page).to have_content("#{video_2.title} #{video_1.title}")
      end
    end
  end
end

describe 'bookmark logged in or out' do
  scenario 'when logged out it shows a tooltip and directs me to the login page' do
    tutorial = create(:tutorial)
    video_1 = create(:video, tutorial_id: tutorial.id, position: 1)
    visit(tutorial_path(tutorial))
    expect(page).to have_css("#login-to-add-bookmark-tooltip")
    click_on "Bookmark"
    expect(current_path).to eq(login_path)
  end
  scenario 'when logged in there is no tooltip' do
    tutorial = create(:tutorial)
    video_1 = create(:video, tutorial_id: tutorial.id, position: 1)
    user_1 = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)

    visit(tutorial_path(tutorial))
    expect(page).to_not have_css("#login-to-add-bookmark-tooltip")
  end
end
