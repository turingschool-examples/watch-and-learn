require 'rails_helper'

describe 'As an Admin' do
  before :each do
    @tutorial = create(:tutorial)
    @admin = create(:user, role: 1)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
    visit tutorial_path(@tutorial)
  end

  it 'Tutorial show page will prompt Admin to create a new video if none exist.' do
    expect(find_field('videos_video_id'))
    expect(find_field('videos_description'))
    expect(find_button('Save'))
  end
end
