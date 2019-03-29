require 'rails_helper'

describe 'an Admin' do
  it 'can create a new videos through tutorial edit', :vcr do
    admin = create(:user, role: 1)
    tutorial = create(:tutorial)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit edit_admin_tutorial_path(admin, tutorial)

    click_on 'Add Video'

    fill_in 'video[title]', with: 'first video'
    fill_in 'video[description]', with: 'this is first video'
    fill_in 'video[video_id]', with: "v5LcjH8CXXg "

    click_on 'Create Video'

    expect(Video.count).to eq(1)
  end

  it 'can not create new video with invalid youtube id', :vcr do
    admin = create(:user, role: 1)
    tutorial = create(:tutorial)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit edit_admin_tutorial_path(admin, tutorial)

    click_on 'Add Video'

    fill_in 'video[title]', with: 'first video'
    fill_in 'video[description]', with: 'this is first video'
    fill_in 'video[video_id]', with: "v5LcjH8" ##not a valid one

    click_on 'Create Video'

    expect(Video.count).to eq(0)
    expect(page).to have_content("Unable to create video.")
  end
end
