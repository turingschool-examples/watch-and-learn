require 'rails_helper'

describe 'As an Admin' do
  before :each do
    @admin = create(:user, role: 1)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
    visit '/admin/tutorials/new'
  end

  it 'I can create a new tutorial with valid params' do
    fill_in 'Title', with: 'title'
    fill_in 'Description', with: 'description'
    fill_in 'Thumbnail', with: 'http://i3.ytimg.com/vi/jyBY-I37P9M/maxresdefault.jpg'
    fill_in 'videos_video_id', with: 'https://www.youtube.com/watch?v=PTbf-VL5UiE'
    fill_in 'videos_description', with: 'Video Description'

    click_button 'Save'

    id = Tutorial.last.id

    expect(current_path).to eq("/tutorials/#{id}")

    expect(page).to have_content('Successfully created tutorial.')
  end

  it 'I cannot create a new tutorial with invalid params' do
    fill_in 'Title', with: 'title'
    fill_in 'Thumbnail', with: 'http://i3.ytimg.com/vi/jyBY-I37P9M/maxresdefault.jpg'

    click_button 'Save'

    expect(page).to have_content('Must fill out all fields to create tutorial.')
  end
end
