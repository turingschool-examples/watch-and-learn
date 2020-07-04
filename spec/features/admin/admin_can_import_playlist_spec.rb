require 'rails_helper'

feature "An admin visiting the admin dashboard" do
  let(:admin)    { create(:admin) }

  scenario "can add a tutorial using youtube playlist id" do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit new_admin_tutorial_path
    click_on "Import YouTube Playlist"

    expect(current_path).to eq(new_admin_youtube_playlist_path)

    fill_in :playlist_id, with: "PL1Y67f0xPzdOq2FcpWnawJeyJ3ELUdBkJ"
    click_on "Import Playlist"

    expect(current_path).to eq(admin_dashboard_path)
    expect(page).to have_content("Successfully created tutorial. View it here.")

    click_on "View it here"
    tutorial = Tutorial.last

    expect(current_path).to eq(tutorial_path(tutorial))
    expect(page).to have_css(".video-link", count: 10)
    video_1 = Video.find_by(position: 0)
    video_2 = Video.find_by(position: 1)
    video_3 = Video.find_by(position: 2)

    expect(video_1.title).to appear_before(video_2.title)
    expect(video_2.title).to appear_before(video_3.title)
  end

  scenario "cannot add a tutorial using bad youtube playlist id" do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit new_admin_tutorial_path
    click_on "Import YouTube Playlist"

    expect(current_path).to eq(new_admin_youtube_playlist_path)

    fill_in :playlist_id, with: "12345abcde"
    click_on "Import Playlist"

    expect(current_path).to eq(new_admin_youtube_playlist_path)
    expect(page).to have_content("Sorry, that ID is not valid. Try again?")
  end
end
