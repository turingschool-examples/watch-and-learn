require 'rails_helper'

describe "an admin can add a playlist" do
  it "can import the playlist from Youtube" do
    admin = create(:admin)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit new_admin_tutorial_path
    fill_in "Title", with: "Tutorial"
    fill_in "Description", with: "Description"
    fill_in "Thumbnail", with: "https://i.ytimg.com/vi/HAUgCZFyxRw/default.jpg"
    click_on "Import YouTube Playlist"
    fill_in 'Playlist ID', with: "PLjiB1Gm1BUm_hM4HArla8kE7C-hdXsMAJ"
    click_on "Save"
    expect(current_path).to eq(admin_dashboard_path)

    expect(page).to have_content("Successfully created tutorial. View it here.")
    click_on "View it here."
    tutorial = Tutorial.last
    expect(current_path).to eq(tutorial_path(tutorial.id))
    expect(tutorial.videos.count).to be > 50

    first_video = tutorial.videos.first
    last_video = tutorial.videos.last
    consecutive_vid_a = tutorial.videos[49]
    consecutive_vid_b = tutorial.videos[50]
    consecutive_vid_c = tutorial.videos[51]

    expect(last_video).to eq(Video.last)
    expect(first_video.tutorial_id).to eq(tutorial.id)
    expect(consecutive_vid_a.tutorial.id).to eq(tutorial.id)
    expect(last_video.tutorial_id).to eq(tutorial.id)
    expect(first_video.title).to eq('Felix Jaehn, VIZE - Close Your Eyes (Official Audio) ft. Miss Li')
    expect(last_video.title).to eq('Tiësto - WOW (Official Video)')
    expect(consecutive_vid_a.title).to appear_before(consecutive_vid_b.title)
    expect(consecutive_vid_b.title).to appear_before(consecutive_vid_c.title)
    expect(consecutive_vid_c.title).to appear_before(last_video.title)
  end
end

# As an admin
# When I visit '/admin/tutorials/new'
# Then I should see a link for 'Import YouTube Playlist'
# When I click 'Import YouTube Playlist'
# Then I should see a form
#
# And when I fill in 'Playlist ID' with a valid ID
# Then I should be on '/admin/dashboard'
# And I should see a flash message that says 'Successfully created tutorial. View it here.'
# And 'View it here' should be a link to '/tutorials/:id'
# And when I click on 'View it here'
# Then I should be on '/tutorials/:id'
# And I should see all videos from the YouTube playlist
# And the order should be the same as it was on YouTube

# Retain the original sequence from YouTube
# Creates a video record for each video in the playlist and stores the youtube id.
# Associates each video stored in the DB is associated with a tutorial. (validate presence of tutorial id)
# Can import a playlist with more than 50 videos
