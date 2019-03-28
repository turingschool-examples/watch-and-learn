# frozen_string_literal: true

require 'rails_helper'

describe 'an Admin' do
  it 'can create a new tutorial by filling out a form in admin new tutorial path' do
    admin = create(:user, role: 1)
    # rubocop:disable Metrics/LineLength
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
    # rubocop:enable Metrics/LineLength

    visit new_admin_tutorial_path(admin)
    expect(Tutorial.count).to eq(0)

    fill_in 'tutorial[title]', with: 'first tutorial'
    fill_in 'tutorial[description]', with: 'this is first tutorial'
    fill_in 'tutorial[thumbnail]', with: 'https://i.ytimg.com/vi/qMkRHW9zE1c/hqdefault.jpg'

    click_on 'Save'
    expect(Tutorial.count).to eq(1)
    expect(page).to have_content('Successfully created tutorial')
  end

  it 'can create a new tutorial with a youtube playlist', :vcr do
    admin = create(:user, role: 1)
    # rubocop:disable Metrics/LineLength
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
    # rubocop:enable Metrics/LineLength

    visit new_admin_tutorial_path(admin)
    click_on 'Import YouTube Playlist'
    fill_in 'tutorial[playlist_id]', with: 'PLpFmLQlYTnx-umq6uGwkhO7Cr_V7rwgyM'
    fill_in 'tutorial[title]', with: 'first tutorial'
    fill_in 'tutorial[description]', with: 'this is first tutorial'
    fill_in 'tutorial[thumbnail]', with: 'https://i.ytimg.com/vi/qMkRHW9zE1c/hqdefault.jpg'
    click_on 'Save'
    expect(Tutorial.count).to eq(1)
    expect(current_path).to eq('/admin/dashboard')
    expect(page).to have_content('Successfully created tutorial. View It Here.')
    click_on 'View It Here.'
    expect(current_path).to eq(tutorial_path(Tutorial.first))
    expect(Video.count).to eq(2)
    expect(Video.first.position).to eq(0)
    expect(Video.last.position).to eq(1)
  end
end
