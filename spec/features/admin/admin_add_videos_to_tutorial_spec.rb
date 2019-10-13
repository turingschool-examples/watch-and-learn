require 'rails_helper'

describe 'Admin Edit Tutorial' do
  it 'Admin can add videos to the tutorial' do
    t1 = create(:tutorial)
    v1 = create(:video, tutorial: t1)
    v2 = create(:video, tutorial: t1)
    v3 = create(:video, tutorial: t1)

    admin = create(:admin)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit "/admin/tutorials/#{t1.id}/edit"

    click_on 'Add Video'

    fill_in 'Title', with: ''
    fill_in 'Description', with: ''
    fill_in "video_video_id", with: ''

    click_on 'Create Video'

    expect(page).to have_content('Unable to create video')

    fill_in 'Title', with: 'New Video'
    fill_in 'Description', with: 'This is my new video'
    fill_in 'video_video_id', with: 'pPy0GQJLZUM'

    expect(page).to have_content('New Video')
    click_on 'Save Video Order'
  end
end
