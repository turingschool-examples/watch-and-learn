require 'rails_helper'

context 'As a logged-in admin' do
  it 'can successfully update a video for a tutorial' do
    admin = create(:admin)
    tutorial = create(:tutorial)
    video = create(:video)
    tutorial.videos << video
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit tutorial_path(tutorial)

    click_button('Edit Video')
    expect(current_path).to eq(edit_admin_video_path(video))

    fill_in 'video[title]', with: 'NEW TITLE'
    click_button 'Update Video'

    expect(current_path).to eq(tutorial_path(tutorial))
    expect(page).to have_content('NEW TITLE')
  end
end
