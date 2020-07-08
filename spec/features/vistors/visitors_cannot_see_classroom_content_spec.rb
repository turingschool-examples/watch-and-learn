require 'rails_helper'

describe 'visitor visits video show page' do
  it 'clicks on the bookmark page and is sent to the log in page' do
    tutorial = create(:tutorial, classroom: true)
    tutorial_2 = create(:tutorial)
    video = create(:video, tutorial_id: tutorial.id)
    video_2 = create(:video, tutorial_id: tutorial_2.id)

    visit root_path
    expect(page).to_not have_content(tutorial.title)
    expect(page).to have_content(tutorial_2.title)

    visit tutorial_path(tutorial.id)
    expect(page).to have_content("You cannot access classroom content without an account.")
    expect(current_path).to eq(root_path)

    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    visit root_path

    expect(page).to have_content(tutorial.title)
    expect(page).to have_content(tutorial_2.title)
  end
end
