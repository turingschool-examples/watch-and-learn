require 'rails_helper'

describe "An Admin can edit a video" do
  let(:video) { create(:video) }
  let(:admin)    { create(:admin) }

  scenario "changing it's name", :js, :vcr do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit edit_admin_video_path(video)


    expect(current_path).to eq(edit_admin_video_path(video))

  end
end
