require 'rails_helper'

describe "As an admin user" do
  before(:each) do
    @admin = create(:admin)
    stub_login(@admin)
  end

  it "I can update a video's information" do
    video = create(:video)

    visit edit_admin_video_path(video)

    fill_in 'video[title]', with: "This is a test"
    fill_in 'video[description]', with: "Why wouldn't this work"

    click_on "Update Video"

    expect(current_path).to eq(tutorial_path(video.tutorial))
    expect(page).to have_content("This is a test")
    expect(page).to have_content("Why wouldn't this work")
  end
end
