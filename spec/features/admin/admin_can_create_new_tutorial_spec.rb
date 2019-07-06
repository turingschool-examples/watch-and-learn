# frozen_string_literal: true

require 'rails_helper'

describe 'An admin user can create new tutorials' do
  it 'clicks on the new tutorial' do
    admin = create(:user, role: 1)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit new_admin_tutorial_path

    fill_in "Title", with: "New Videos"
    fill_in "Description", with: "Here are the new videos"
    fill_in "Thumbnail", with: "NothingHere"

    click_button "Save"

    new_tutorial = Tutorial.last

    expect(current_path).to eq(tutorial_path(new_tutorial))
    expect(new_tutorial.title).to eq("New Videos")
    expect(new_tutorial.description).to eq("Here are the new videos")
    expect(new_tutorial.thumbnail).to eq("NothingHere")
    expect(page).to have_content("Successfully created tutorial.")
  end

  it "if fields blank redirects new with error" do
    admin = create(:user, role: 1)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit new_admin_tutorial_path

    fill_in "Description", with: "Here are the new videos"
    fill_in "Thumbnail", with: "NothingHere"

    click_button "Save"

    new_tutorial = Tutorial.last

    expect(current_path).to eq(admin_tutorials_path)
    expect(page).to have_content("Title can't be blank")
  end
end
