require 'rails_helper'

RSpec.describe "When I visit '/admin/tutorials/new'" do
  let(:admin)    { create(:admin) }

  it "I can fill in the new tutorial form" do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit '/admin/tutorials/new'

    fill_in "Title", with: "Basic Hygiene Tutorial"
    fill_in "Description", with: "A series of videos covering basic hygiene."
    fill_in "Thumbnail", with: "https://i.ytimg.com/vi/qMkRHW9zE1c/hqdefault.jpg"

    click_on "Save"

    expect(current_path).to eq("/tutorials/#{Tutorial.last.id}")
    expect(page).to have_content("Successfully created tutorial.")
    expect(page).to have_content("Basic Hygiene Tutorial")
    expect(page).to have_content("No tutorial videos have been added.")
  end

  it "cannot create a tutorial if fields are blank" do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit '/admin/tutorials/new'

    fill_in "Title", with: "Basic Hygiene Tutorial"
    fill_in "Description", with: ""
    fill_in "Thumbnail", with: "https://i.ytimg.com/vi/qMkRHW9zE1c/hqdefault.jpg"

    click_on "Save"

    expect(page).to have_content("Please fill in all fields to create this tutorial")
  end
end
