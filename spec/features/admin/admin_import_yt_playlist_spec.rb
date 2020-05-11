require 'rails_helper'

RSpec.describe "When I visit '/admin/tutorials/new' as Admin", type: :feature do
  it "I can click link to import a playlist to create the tutorial" do
    admin = create(:admin)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit new_admin_tutorial_path
    
    click_link 'Import YouTube Playlist'

    expect(current_path).to eq('/admin/import_tutorial/new')

    fill_in "Title", with: "A New Tutorial Title"
    fill_in "Description", with: "Gyrocopter playslist should have 6 videos."
    fill_in "Thumbnail", with: "https://i.ebayimg.com/images/g/fikAAOSwJOJcSWXe/s-l640.jpg"
    fill_in "Playlist", with: 'PLA1C00061BB65843A'

    click_button "Create"
    
    expect(current_path).to eq('/admin/dashboard')
   
    expect(page).to have_content('Successfully created tutorial. View it here.')
    click_link 'View it here'

    tutorial = Tutorial.last
    
    expect(current_path).to eq(tutorial_path(tutorial))
    
    order = tutorial.videos.map { |vid| vid.video_id }
    
    expect(order).to eq(["GAoK9zM8FFQ", "wmHc2utId6c", "55cFpRycdKI", "CFNc1iY8wi0", "nY8SmllLcIU", "s-tibm_dPFQ"])
    expect(tutorial.videos.count).to eq(6)
    expect(tutorial.videos.first.position).to eq(0)
    expect(tutorial.videos.last.position).to eq(5)
  end

  it "I can create a tutorial with a playlist of greater than 50 videos" do
    admin = create(:admin)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
    
    visit '/admin/import_tutorial/new'

    fill_in "Title", with: "SNL"
    fill_in "Description", with: "A playlist of 88 greatest skits of all time videos"
    fill_in "Thumbnail", with: "https://i.ebayimg.com/images/g/fikAAOSwJOJcSWXe/s-l640.jpg"
    fill_in "Playlist", with: 'PLFz4Zf531DCDlhwNQLk64yJwofKHyu9jo'

    click_button "Create"

    click_link 'View it here'

    tutorial = Tutorial.last

    expect(tutorial.videos.count).to eq(88)
  end
end