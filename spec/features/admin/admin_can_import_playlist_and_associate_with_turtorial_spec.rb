require "rails_helper"

feature "Admin can create turtorial playlist" do
  scenario "relates playlist to existing turtorial and imports videos" do

    json_playlist_user = File.read("spec/fixtures/youtube_playlist_videos.json")
    stub_request(:get, "https://www.googleapis.com/youtube/v3/playlistItems?key=AIzaSyCzagb2Z4azIWluJz9b9q-fxPlm6yuro6M&part=snippet&playlistId=PL1Y67f0xPzdOq2FcpWnawJeyJ3ELUdBkJ").
        with(
          headers: {
         'Accept'=>'*/*',
         'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
         'User-Agent'=>'Faraday v1.0.1'
          }).
        to_return(status: 200, body: json_playlist_user, headers: {})

    admin = create(:admin)
    tutorial = create(:tutorial)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
    visit '/admin/tutorials/new'



    # click_link('Import YouTube Playlist')
    fill_in :playlist_id, with: "PL1Y67f0xPzdOq2FcpWnawJeyJ3ELUdBkJ"
    click_button "Submit"
    expect(current_path). to eql("/admin/dashboard")
    expect(page).to have_content("Successfully created tutorial. View it Here.")
    click_on "View it Here"
    expect(current_path). to eql("/tutorials/#{Tutorial.last.id}")


    #expect(current_path).to eql '/admin/tutorials/#tutorial.first/new'
  end
end

#youtube playlist_id
#PL1Y67f0xPzdOq2FcpWnawJeyJ3ELUdBkJ
