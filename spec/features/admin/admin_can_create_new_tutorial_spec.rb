require 'rails_helper'

describe "Admin Controls" do
  scenario "Admin can create a new tutorial using a form" do
    admin = create(:admin)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit '/admin/tutorials/new'

    fill_in "tutorial[title]", with: "Make It Fancy"
    fill_in "tutorial[description]", with: "Learn how to turn simple recipes to a gourmet meal easy"
    fill_in "tutorial[thumbnail]", with: "http://img.youtube.com/vi/Y2NGZl4JHNs/default.jpg"

    click_on "Save"
    expect(current_path).to eq("/tutorials/#{Tutorial.last.id}")
    expect(page).to have_content("Successfully created tutorial")
  end

  scenario "Admin can't create a new video if form is not 100% filled" do
    admin = create(:admin)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit '/admin/tutorials/new'

    fill_in "tutorial[title]", with: " "
    fill_in "tutorial[description]", with: "Learn how to turn simple recipes to a gourmet meal easy"
    fill_in "tutorial[thumbnail]", with: "http://img.youtube.com/vi/Y2NGZl4JHNs/default.jpg"

    click_on "Save"
    expect(page).to have_content("Title can't be blank")
  end
end
