require 'rails_helper'
feature 'admin can see more than 50 videos' do
  scenario "As an admin I " do

    VCR.use_cassette('Can pull more than 50 videos from a playlist') do
      admin = create(:admin)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit '/admin/tutorials/new'

      click_on 'Import YouTube Playlist'
      fill_in 'Title', with: "My New Playlist Tutorial"
      fill_in 'Description', with: "Testing importing playlists"
      fill_in 'Thumbnail', with: "random.jpg"
      fill_in "tutorial[playlist_id]", with: "PLEguIFSuqm6gq3j2h8wvBXJSVq-MhE5VF"
      click_on 'Create Playlist'

      tutorial = Tutorial.last

      expect(tutorial.videos.count).to eq 64
      expect(current_path).to eq(admin_dashboard_path)
    end
  end
end
