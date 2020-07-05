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
end

# When I visit '/admin/tutorials/new'
# And I fill in 'title' with a meaningful name
# And I fill in 'description' with a some content
# And I fill in 'thumbnail' with a valid YouTube thumbnail
# And I click on 'Save'
# Then I should be on '/tutorials/{NEW_TUTORIAL_ID}'
# And I should see a flash message that says "Successfully created tutorial."
