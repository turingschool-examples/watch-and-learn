# string_literal: true

require 'rails_helper'

describe 'An Admin can edit a video' do
  it 'by editing a video' do
    admin = create(:admin)
    video = create(:video)
    title = "abc"
    description = "abc"
    thumbnail = "abc"

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit edit_admin_video_path(video)

  end
end
