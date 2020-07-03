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

    # confirm order with orderly using id = video.position
  end

  xscenario "cannot add a tutorial using bad youtube playlist id" do
    #create sad path tests for invalid playlist id
  end
end
