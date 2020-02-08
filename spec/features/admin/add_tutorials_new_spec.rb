require 'rails_helper'

describe "An Admin can create a tutorial" do
  let(:admin)    { create(:admin) }

  scenario "by adding a tutorial with a title and description", :js, :vcr do

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
    visit new_admin_tutorial_path

    fill_in "tutorial[title]", with: "The Best Way To Code"
    fill_in "tutorial[description]", with: "An in depth look at modern coding."
    fill_in "tutorial[thumbnail]", with: "https://i.ytimg.com/vi/qMkRHW9zE1c/hqdefault.jpg"
    click_on "Save"

    tutorial = Tutorial.last

    expect(tutorial.title).to eq("The Best Way To Code")
    expect(tutorial.description).to eq("An in depth look at modern coding.")
    expect(current_path).to eq(tutorial_path(tutorial))
    expect(page).to have_content("Successfuly created tutorial.")

    expect(page).to have_content("The Best Way To Code")
  end

  scenario "admin cannot enter an invalid title or description", :js, :vcr do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit new_admin_tutorial_path

    fill_in "tutorial[title]", with: "Duh"
    fill_in "tutorial[description]", with: "I don't know."
    fill_in "tutorial[thumbnail]", with: "https://i.ytimg.com/vi/qMkRHW9zE1c/hqdefault.jpg"

    click_on "Save"

    expect(current_path).to eq(new_admin_tutorial_path)
    expect(page).to have_content("title must be 5 characters long")
    expect(page).to have_content("description must be 10 characters long")
  end
end
