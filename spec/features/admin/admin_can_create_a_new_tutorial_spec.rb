require 'rails_helper'

RSpec.feature "As an admin user" do
  before(:each) do
    @admin = create(:admin)
    stub_login(@admin)
    @tutorial = build(:tutorial)
  end

  it "I can create a new tutorial" do

    visit new_admin_tutorial_path

    fill_in 'tutorial[title]', with: "This is a test"
    fill_in 'tutorial[description]', with: "Why wouldn't this work"
    fill_in 'tutorial[thumbnail]', with: "www.google.com"

    click_on "Save"

    # expect(current_path).to eq(tutorial_path)

    # expect(current_path).to eq(tutorial_path(video.tutorial))
    expect(page).to have_content("This is a test")
    expect(page).to have_content("Why wouldn't this work")
  end
end
