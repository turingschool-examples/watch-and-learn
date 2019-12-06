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

  it "sorts bookmarked videos by position and tutorial" do
    tutorial= create(:tutorial)
    video_1 = create(:video, tutorial_id: tutorial.id, position: 1)
    video_2 = create(:video, tutorial_id: tutorial.id, position: 2)
    tutorial_2= create(:tutorial)
    video_3 = create(:video, tutorial_id: tutorial_2.id, position: 1)
    video_4 = create(:video, tutorial_id: tutorial_2.id, position: 2)
    video_5 = create(:video, tutorial_id: tutorial_2.id, position: 3)
    user = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    visit "/tutorials/#{tutorial.id}?video_id=#{video_1.id}"
    click_on 'Bookmark'
    visit "/tutorials/#{tutorial.id}?video_id=#{video_2.id}"
    click_on 'Bookmark'

    visit "/tutorials/#{tutorial_2.id}?video_id=#{video_5.id}"
    click_on 'Bookmark'
    visit "/tutorials/#{tutorial_2.id}?video_id=#{video_3.id}"
    click_on 'Bookmark'

    visit dashboard_path

    within ".tutorial-#{tutorial.id}" do
      expect(page).to have_content(tutorial.title)
      within ".video-pos-0" do
        expect(page).to have_link(video_1.title)
      end
      within ".video-pos-1" do
        expect(page).to have_link(video_2.title)
      end
    end

    within ".tutorial-#{tutorial_2.id}" do
      within ".video-pos-0" do
        expect(page).to have_link(video_3.title)
      end
      within ".video-pos-1" do
        expect(page).to have_link(video_5.title)
      end
      expect(page).to_not have_css('.video-pos-2')
    end
  end
end
