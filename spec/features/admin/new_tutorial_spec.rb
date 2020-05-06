require 'rails_helper'

RSpec.describe "As an admin,", type: :feature do 
  before :each do 
    admin = create(:admin)
    tutorial = create(:tutorial)
    tutorial1 = create(:tutorial)
    video1 = create(:video, tutorial_id: tutorial.id)
    video2 = create(:video, tutorial_id: tutorial1.id)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
    visit "/admin/tutorials/new"
    click_on "Import YouTube Playlist"
  end

  it "I can visit a link that shows a form to import YouTube Playlist.", :js do
    expect(page).to have_current_path("/admin/tutorials/new/import")
    expect(page).to have_content("Playlist ID:")
  end
  
  it "I can import a YouTube Playlist by inputting a Playlist ID." do 
    fill_in :playlist_id, with: "5"
  end
end

# As an admin
# When I visit '/admin/tutorials/new'
# Then I should see a link for 'Import YouTube Playlist'
# When I click 'Import YouTube Playlist'
# Then I should see a form

# And when I fill in 'Playlist ID' with a valid ID
# Then I should be on '/admin/dashboard'
# And I should see a flash message that says 'Successfully created tutorial. View it here.'
# And 'View it here' should be a link to '/tutorials/:id'
# And when I click on 'View it here'
# Then I should be on '/tutorials/:id'
# And I should see all videos from the YouTube playlist
# And the order should be the same as it was on YouTube