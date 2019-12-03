require 'rails_helper'

RSpec.describe "When I visit '/admin/tutorials/new'" do
  let(:admin)    { create(:admin) }

  it "I can fill in the new tutorial form" do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit '/admin/tutorials/new'

    fill_in "Title", with: "How to brush your teeth"
    fill_in "Description", with: "Electric toothbrush or toothbrush"
    fill_in "Thumbnail", with: "https://www.youtube.com/watch?v=bifu6CzomHI"

    click_on "Save"

    expect(current_path).to eq("/tutorials/#{Tutorial.last.id}")
    expect(page).to have_content("Successfully created tutorial.")
  end
end
