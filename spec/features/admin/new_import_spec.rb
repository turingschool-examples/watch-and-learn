require 'rails_helper'

RSpec.describe "As an admin,", type: :feature do
  before :each do
    @admin = create(:admin)
    @tutorial = create(:tutorial)
    @tutorial1 = create(:tutorial)
    @video1 = create(:video, tutorial_id: @tutorial.id)
    @video2 = create(:video, tutorial_id: @tutorial1.id)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
    visit "/admin/tutorials/new"
    click_on "Import YouTube Playlist"
  end

  it "I can visit a link that shows a form to import YouTube Playlist.", :js do
    expect(page).to have_current_path("/admin/tutorials/new/import")
    expect(page).to have_content("Playlist ID:")
  end

  it "I can import a YouTube Playlist by inputting a Playlist ID." do
    fill_in :title, with: "Test-Tutorial"
    fill_in :description, with: "I hate this"
    fill_in :thumbnail, with: "https://i.pinimg.com/564x/23/05/82/230582bf2487046449ddc45915cbd7f7.jpg"
    fill_in :playlist_id, with: "PLvyrcOJeR7wnwL7KtaqYgaHkel0XBHzzI"
    click_on "Import"

    expect(page).to have_current_path("/admin/dashboard")
    save_and_open_page
    # expect(page).to have_content("Successfully created tutorial. View it here.")

    click_on "View it here."
    expect(page).to have_current_path("/tutorials/#{@tutorial}")
    # And I should see all videos from the YouTube playlist
    # And the order should be the same as it was on YouTube
  end
end
# Then I should be on '/tutorials/:id'
# And I should see all videos from the YouTube playlist
# And the order should be the same as it was on YouTube
