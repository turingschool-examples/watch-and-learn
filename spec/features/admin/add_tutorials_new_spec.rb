require 'rails_helper'

describe "An Admin can create a tutorial" do
  let(:admin)    { create(:admin) }

  scenario "by adding a tutorial with a video assocation", :js, :vcr do

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
    visit new_admin_tutorial_path

    fill_in "tutorial[title]", with: "The Best Way To Code"
    fill_in "tutorial[description]", with: "An in depth look at modern coding."
    fill_in "tutorial[thumbnail]", with: "https://i.ytimg.com/vi/qMkRHW9zE1c/hqdefault.jpg"

    fill_in "tutorial[videos_attributes][0][title]", with: 'Super Terrific Video'
    fill_in "tutorial[videos_attributes][0][description]", with: 'A fun way to spend the day.'
    fill_in "tutorial[videos_attributes][0][thumbnail]", with: 'https://i.ytimg.com/vi/qMkRHW9zE1c/hqdefault.jpg'
    fill_in 'tutorial[videos_attributes][0][video_id]', with: 'https://www.youtube.com/watch?v=acQS2Fef8tU'

    click_on "Save"

    tutorial = Tutorial.last

    expect(tutorial.title).to eq("The Best Way To Code")
    expect(tutorial.description).to eq("An in depth look at modern coding.")
    expect(current_path).to eq(tutorial_path(tutorial))
    expect(page).to have_content("Successfuly created tutorial")

    expect(page).to have_content("The Best Way To Code")

    video = tutorial.videos.first
    expect(video.title).to eq("Super Terrific Video")
    expect(video.description).to eq("A fun way to spend the day.")
  end

  scenario "admin create a tutorial without a video", :js, :vcr do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit new_admin_tutorial_path
    fill_in "tutorial[title]", with: 'The best words to live by.'
    fill_in "tutorial[description]", with: "I don't know how I lived without this."
    fill_in "tutorial[thumbnail]", with: 'https://i.ytimg.com/vi/qMkRHW9zE1c/hqdefault.jpg'

    click_on "Save"
    tutorial = Tutorial.last

    expect(tutorial.title).to eq('The best words to live by.')
    expect(tutorial.description).to eq("I don't know how I lived without this.")
    expect(current_path).to eq(tutorial_path(tutorial))
    expect(page).to have_content('Successfuly created tutorial')

    expect(page).to have_content('The best words to live by.')
  end

  scenario 'admin cannot enter an invalid title or description', :js, :vcr do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit new_admin_tutorial_path
    fill_in "tutorial[title]", with: "Duh"
    fill_in "tutorial[description]", with: ""
    fill_in "tutorial[thumbnail]", with: "https://i.ytimg.com/vi/qMkRHW9zE1c/hqdefault.jpg"

    click_on "Save"

    expect(current_path).to eq(new_admin_tutorial_path)
    expect(page).to have_content("Title is too short (minimum is 5 characters)")
  end
end
