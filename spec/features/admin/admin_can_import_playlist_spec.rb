require 'rails_helper'

describe 'As an admin'
  describe 'When I visit /admin/tutorials/new' do
    it 'I can import a youtube playlist' do
      admin = create(:user, role: 1)
      playlist_id = 'PLbt09tWqepBSRQstKuZjrOrX-9xNPY3CE'

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
      stubbed_videos =  [{
        title: "fake title",
        description: "this is a description",
        thumbnail: "url",
        position: 5,
        video_id: 7
        },
      {
        title: "second title",
        description: "another description",
        thumbnail: "url",
        position: 10,
        video_id: 8
        }]
      
    allow_any_instance_of(YoutubeService).to receive(:fetch_videos_for_playlist).and_return(stubbed_videos)
      
    visit '/admin/tutorials/new'

    fill_in 'Title', with: "New Tutorial"
    fill_in 'Description', with: "Decription stuff"
    fill_in 'Thumbnail', with: "https://i.ytimg.com/vi/qMkRHW9zE1c/hqdefault.jpg"

    click_on 'Import YouTube Playlist'
    tutorial = Tutorial.last
    expect(current_path).to eq("/admin/tutorials/#{tutorial.id}/playlists/new")

    fill_in 'playlist_id', with: playlist_id
    click_on 'Import'

    expect(current_path).to eq("/admin/dashboard")
    
    expect(page).to have_content('Successfully created tutorial. View it here.')

    click_on('View it here')
    
    expect(current_path).to eq("/tutorials/#{tutorial.id}")
    
    within('.tutorials') do
      expect(page).to have_content(Tutorial.last.title)
    end

    within(".tutorial-videos") do
      videos = page.all("li")
      expect(videos[0]).to have_content('fake title')
      expect(videos[1]).to have_content('second title')
    end
  end
end
