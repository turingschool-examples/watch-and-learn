require 'rails_helper'

RSpec.describe "As an admin,", type: :feature do
  before :each do
    @admin = create(:admin)
    @tutorial = create(:tutorial)
    @tutorial1 = create(:tutorial)
    @video1 = create(:video, tutorial_id: @tutorial.id)
    @video2 = create(:video, tutorial_id: @tutorial1.id)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
  end

  it "I can visit a link that shows a form to import YouTube Playlist.", :js do
    visit "/admin/tutorials/new"
    click_on "Import YouTube Playlist"

    expect(page).to have_current_path("/admin/tutorials/import")
    expect(page).to have_content("Title")
    expect(page).to have_content("Description")
    expect(page).to have_content("Thumbnail")
    expect(page).to have_content("Playlist ID")
  end

  it "I can import a YouTube Playlist by inputting a Playlist ID and see all videos from said Playlist." do
    visit "/admin/tutorials/new"
    click_on "Import YouTube Playlist"

    fill_in :title, with: "Test-Tutorial"
    fill_in :description, with: "I hate this"
    fill_in :thumbnail, with: "https://i.pinimg.com/564x/23/05/82/230582bf2487046449ddc45915cbd7f7.jpg"
    fill_in :playlist_id, with: "PLvyrcOJeR7wnwL7KtaqYgaHkel0XBHzzI"
    click_on "Import"

    expect(page).to have_current_path("/admin/dashboard")
    expect(page).to have_content("Successfully created tutorial. View it here.")

    last_tutorial = Tutorial.last
    this = last_tutorial.videos[0].title
    that = last_tutorial.videos[1].title

    click_on "View it here."

    expect(page).to have_current_path("/tutorials/#{last_tutorial.id}")
    expect(page).to have_content(this)
    expect(page).to have_content(that)
    expect(this).to appear_before(that)
  end

  it "I can create a new tutorial with a playlist that contains 50+ videos." do
    visit "/admin/tutorials/new"
    click_on "Import YouTube Playlist"

    fill_in :title, with: "Test-Tutorial"
    fill_in :description, with: "50 videos"
    fill_in :thumbnail, with: "https://i.pinimg.com/564x/23/05/82/230582bf2487046449ddc45915cbd7f7.jpg"
    fill_in :playlist_id, with: "PLDIoUOhQQPlXr63I_vwF9GD8sAKh77dWU"
    click_on "Import"

    click_on "View it here."

    last_tutorial = Tutorial.last
    first_video = last_tutorial.videos.first
    last_video = last_tutorial.videos.last

    expect(last_tutorial.videos.size).to eq(100)
    expect(first_video.title).to be_truthy
    expect(first_video.description).to be_truthy
    expect(first_video.id).to be_truthy
    expect(first_video.thumbnail).to be_truthy
    expect(last_video.title).to be_truthy
    expect(last_video.id).to be_truthy
  end
end
