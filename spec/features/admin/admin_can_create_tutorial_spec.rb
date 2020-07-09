require 'rails_helper'

describe "an admin can add a tutorial" do
  before :each do
    @admin = create(:admin)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
    visit new_admin_tutorial_path
  end

  it "can add a tutorial" do
    fill_in "Title", with: "A meaningful name"
    fill_in "Description", with: "Some content"
    fill_in "Thumbnail", with: "https://i.ytimg.com/vi/HAUgCZFyxRw/default.jpg"
    click_on "Save"

    tutorial = Tutorial.last
    expect(current_path).to eq(tutorial_path(tutorial.id))
    expect(page).to have_content("Successfully created tutorial.")
  end

  it "does not add a tutorial when there is incomplete info" do
    fill_in "Description", with: "Some content."
    fill_in "Thumbnail", with: "this doesn't really matter because it shouldn't be saved"
    click_on "Save"

    expect(current_path).to eq(new_admin_tutorial_path)
    expect(page).to have_content("Title can't be blank")

    fill_in "Title", with: "A meaningful name"
    fill_in "Description", with: ""
    fill_in "Thumbnail", with: "this doesn't really matter because it shouldn't be saved"
    click_on "Save"

    expect(current_path).to eq(new_admin_tutorial_path)
    expect(page).to have_content("Description can't be blank")
  end
end
