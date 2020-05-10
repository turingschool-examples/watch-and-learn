require 'rails_helper'

RSpec.describe "When I visit '/admin/tutorials/new' as Admin", type: feature do
  it "I can click link to import a playlist to create the tutorial" do
    admin = create(:admin)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit new_admin_tutorial_path

    click_link 'Import YouTube Playlist'

    # expect(current_path).to eq(new_admin_tutorial_path) # <-- NEED A CONTROLLER/PATH

    fill_in "Title", with: "A New Tutorial Title"
    fill_in "Description", with: "Gyrocopter playslist should have 6 videos."
    fill_in "Thumbnail", with: "https://i.ebayimg.com/images/g/fikAAOSwJOJcSWXe/s-l640.jpg"
    fill_in "Playlist ID", with: 'PLA1C00061BB65843A'

    click_button "Create"
    
    expect(current_path).to eq('/admin/dashboard')
    expect(page).to have_content('Successfully created tutorial. View it here.')

    click_link 'View it here'

    tutorial = Tutorial.last
    
    expect(current_path).to eq(tutorial_path(tutorial))

    # And I should see all videos from the YouTube playlist
    # And the order should be the same as it was on YouTube

  end
end