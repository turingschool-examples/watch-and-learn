require 'rails_helper'

RSpec.describe "As an Admin", type: :feature do
  it "I can create a new tutorial" do
    admin = create(:admin)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
    visit "/admin/dashboard"

    click_link "New Tutorial"

    expect(current_path).to eq(new_admin_tutorial_path)

    fill_in "Title", with: "A New Tutorial Title"
    fill_in "Description", with: "Some instructional structuring"
    fill_in "Thumbnail", with: "https://www.techymob.com/wp-content/uploads/2019/10/How-to-Download-Thumbnail-from-YouTube.jpg"

    click_button "Save"

    tutorial = Tutorial.last
    
    expect(current_path).to eq(tutorial_path(tutorial))
    expect(page).to have_content("Successfully created tutorial.")
  end

  it "I see an error message if info is omitted during new tutorial creation" do
    admin = create(:admin)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit new_admin_tutorial_path

    fill_in "Title", with: "Another How-To Title"
    fill_in "Description", with: ""
    fill_in "Thumbnail", with: ""
    
    click_button "Save"
    
    expect(page).to have_content("New Tutorial")
    expect(page).to have_content("oops")
  end


end