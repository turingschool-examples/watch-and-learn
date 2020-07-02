require 'rails_helper'

describe 'As an admin' do
  describe 'When I visit the new tutorial page' do
    it 'I see a link to import a youtube playlist' do
      admin = create(:admin)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit '/admin/tutorials/new'

      click_on 'Import YouTube Playlist'

      expect(current_path).to eq('/admin/import_playlist')
    end

    it 'I can import a playlist' do
      admin = create(:admin)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit '/admin/tutorials/new'

      click_on 'Import YouTube Playlist'

      fill_in 'Playlist ID', with: "PLJicmE8fK0EiQLKEhNM8qJL8ExHwQZh_0"
      click_on 'Submit'

      expect(page).to have_content("Successfully created tutorial. View it here.")

      click_on "View it here."

      tutorial = Tutorial.last

      expect(current_path).to eq("/tutorials/#{tutorial.id}")
    end

    # it 'The videos should be in the same order as on YouTube' do
    #
    # end
  end
end
