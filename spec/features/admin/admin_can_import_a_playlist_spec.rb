require 'rails_helper'

describe 'As an admin' do
  describe 'When I visit the new tutorial page' do
    it 'I see a link to import a youtube playlist' do
      admin = create(:admin)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit '/admin/tutorials/new'

      click_on 'Import YouTube Playlist'

      expect(current_path).to eq('/admin/playlists/new')
    end

    it 'I can import a playlist' do
      json_response = File.read('spec/fixtures/playlist_info.json')
      stub_request(:get, "https://www.googleapis.com/youtube/v3/playlistItems?key=AIzaSyCXYWdWx2vQtWi9CqsJe0WT6ryiKgT6BWM&maxResults=50&part=snippet,contentDetails&playlistId=PLJicmE8fK0EiQLKEhNM8qJL8ExHwQZh_0").
         with(
           headers: {
       	  'Accept'=>'*/*',
       	  'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
       	  'User-Agent'=>'Faraday v1.0.1'
           }).
         to_return(status: 200, body: json_response, headers: {})

      admin = create(:admin)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit '/admin/tutorials/new'

      click_on 'Import YouTube Playlist'
      fill_in 'Title', with: "My New Playlist Tutorial"
      fill_in 'Description', with: "Testing importing playlists"
      fill_in 'Thumbnail', with: "random.jpg"
      fill_in "tutorial[playlist_id]", with: "PLJicmE8fK0EiQLKEhNM8qJL8ExHwQZh_0"
      click_on 'Create Playlist'

      expect(page).to have_content("Successfully created tutorial. View it here.")

      click_on "View it here."

      tutorial = Tutorial.last

      expect(current_path).to eq("/tutorials/#{tutorial.id}")
    end

    it 'The videos should be in the same order as on YouTube' do
      json_response = File.read('spec/fixtures/playlist_info.json')
      stub_request(:get, "https://www.googleapis.com/youtube/v3/playlistItems?key=AIzaSyCXYWdWx2vQtWi9CqsJe0WT6ryiKgT6BWM&maxResults=50&part=snippet,contentDetails&playlistId=PLJicmE8fK0EiQLKEhNM8qJL8ExHwQZh_0").
         with(
           headers: {
       	  'Accept'=>'*/*',
       	  'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
       	  'User-Agent'=>'Faraday v1.0.1'
           }).
         to_return(status: 200, body: json_response, headers: {})
      admin = create(:admin)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit '/admin/tutorials/new'

      click_on 'Import YouTube Playlist'
      fill_in 'Title', with: "My New Playlist Tutorial"
      fill_in 'Description', with: "Testing importing playlists"
      fill_in 'Thumbnail', with: "random.jpg"
      fill_in "tutorial[playlist_id]", with: "PLJicmE8fK0EiQLKEhNM8qJL8ExHwQZh_0"
      click_on 'Create Playlist'
      click_on "View it here."

      first_video = "Are you a body with a mind or a mind with a body? - Maryam Alimardani"
      second_video = "Plato’s Allegory of the Cave - Alex Gendler"
      third_video = "The philosophy of Stoicism - Massimo Pigliucci"

      expect(first_video).to appear_before(second_video)
      expect(second_video).to appear_before(third_video)
    end
    it 'Can pull more than 50 videos from a playlist' do
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
      expect(tutorial.videos.count).to eq 65
      expect(current_path).to eq(admin_dashboard_path)
    end
    it 'will error out of incorrect playlist ID' do
      admin = create(:admin)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit '/admin/tutorials/new'

      click_on 'Import YouTube Playlist'
      fill_in 'Title', with: "My New Playlist Tutorial"
      fill_in 'Description', with: "Testing importing playlists"
      fill_in 'Thumbnail', with: "random.jpg"
      fill_in "tutorial[playlist_id]", with: "asdf"
      click_on 'Create Playlist'

      expect(page).to have_content("Not a valid Playlist ID")
      expect(current_path).to eq("/admin/playlists/new")
    end
  end
end
