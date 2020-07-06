require 'rails_helper'

describe 'As an admin'
  describe 'When I visit /admin/tutorials/new' do
    it 'I can import a youtube playlist' do
      admin = create(:user, role: 1)
      playlist_id = 'PLbt09tWqepBSRQstKuZjrOrX-9xNPY3CE'

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
     
      visit '/admin/tutorials/new'

      click_on 'Import YouTube Playlist'
      fill_in'tutorial[playlist_id]', with: playlist_id
      click_on 'Import'

      expect(current_path).to eq('/admin/dashboard')
      expect(page).to have_content('Successfully created tutorial. View it here.')

      click_on('View it here')
      new_tutorial = Tutorial.last
      expect(current_path).to eq("/tutorials/#{new_tutorial.id}")

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