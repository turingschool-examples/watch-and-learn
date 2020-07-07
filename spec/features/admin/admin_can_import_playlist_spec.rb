require 'rails_helper'

describe 'As an admin'
  describe 'When I visit /admin/tutorials/new' do
    it 'I can import a youtube playlist' do
      admin = create(:user, role: 1)
      playlist_id = 'PLbt09tWqepBSRQstKuZjrOrX-9xNPY3CE'

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
     
      visit '/admin/tutorials/new'

      fill_in'Title', with: "New Tutorial"
      fill_in'Description', with: "Decription stuff"
      fill_in'Thumbnail', with: "https://i.ytimg.com/vi/qMkRHW9zE1c/hqdefault.jpg"

      # click_on 'Import YouTube Playlist'
      # expect(current_path).to eq("/admin/playlists/new")

      fill_in'tutorial[playlists][playlist_id]', with: playlist_id
      click_on 'Save'

      tutorial = Tutorial.last
      expect(current_path).to eq("/tutorials/#{tutorial.id}")
      expect(page).to have_content('Successfully created tutorial. View it here.')

      click_on('View it here')
     
      expect(current_path).to eq("/tutorials/#{tutorial.id}")

      # expect(page).to have_content('')
    end
  end



#   As an admin
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

#  Retain the original sequence from YouTube
#  Creates a video record for each video in the playlist and stores the youtube id.
#  Associates each video stored in the DB is associated with a tutorial. (validate presence of tutorial id)
#  Can import a playlist with more than 50 videos