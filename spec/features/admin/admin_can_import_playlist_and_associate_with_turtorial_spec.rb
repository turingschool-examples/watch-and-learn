require "rails_helper"

feature "Admin can create turtorial playlist" do
  scenario "relates playlist to existing turtorial and imports videos" do

    admin = create(:admin)
    tutorial = create(:tutorial)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
    visit '/admin/tutorials/new'



    #click_link('Import YouTube Playlist')
    fill_in :playlist_id, with: "PL1Y67f0xPzdOq2FcpWnawJeyJ3ELUdBkJ"
    click_button "Submit"
    expect(current_path). to eql("/admin/tutorials/#{tutorial.id}/videos")
    
    #expect(current_path).to eql '/admin/tutorials/#tutorial.first/new'
  end
end

#youtube playlist_id
#PL1Y67f0xPzdOq2FcpWnawJeyJ3ELUdBkJ
