require 'rails_helper'

RSpec.describe "When I visit '/admin/tutorials/new'" do
  let(:admin)    { create(:admin) }

  it "I can fill in the new tutorial form" do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit '/admin/tutorials/new'

    within "#new_tutorial_form" do
      fill_in "Title", with: "Basic Hygiene Tutorial"
      fill_in "Description", with: "A series of videos covering basic hygiene."
      fill_in "Thumbnail", with: "https://images.unsplash.com/photo-1418754356805-b89082b6965e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1650&q=80"
    end

    within "#new_video_form" do
      fill_in "Title", with: "How to brush your teeth"
      fill_in "Description", with: "Description for how to brush your teeth"
      fill_in "Video", with: "https://www.youtube.com/watch?v=bifu6CzomHI"
    end

    click_on "Save"

    expect(current_path).to eq("/tutorials/#{Tutorial.last.id}")
    expect(page).to have_content("Successfully created tutorial.")
    expect(page).to have_content("Basic Hygiene Tutorial")
    expect(page).to have_content("How to brush your teeth")
    expect(page).to have_content("Description for how to brush your teeth")
  end

  it "cannot create a tutorial if fields are blank" do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit '/admin/tutorials/new'

    within "#new_tutorial_form" do
      fill_in "Title", with: "Basic Hygiene Tutorial"
      fill_in "Description", with: "A series of videos covering basic hygiene."
      fill_in "Thumbnail", with: "https://images.unsplash.com/photo-1418754356805-b89082b6965e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1650&q=80"
    end

    click_on "Save"

    expect(page).to have_content("Please fill in all fields to create this tutorial")
  end
end
