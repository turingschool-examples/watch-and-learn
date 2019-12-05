require 'rails_helper'

RSpec.describe "As an admin" do
  it "can delete a tutorial and associated videos" do
    admin = create(:user, role: 1)
    tutorial1 = create(:tutorial)
    video1 = create(:video, tutorial_id: tutorial1.id)
    tutorial2 = create(:tutorial)
    video2 = create(:video, tutorial_id: tutorial2.id)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit '/admin/dashboard'

    within(first(".admin-tutorial-card")) do
      click_on 'Destroy'
    end

    expect(current_path).to eq('/admin/dashboard')

    expect(page).to_not have_link(tutorial1.title)
    expect(page).to have_link(tutorial2.title)
    video_ids = Video.pluck(:id)
    expect(video_ids.include?(video1.id)).to be_falsey
    expect(video_ids.include?(video2.id)).to be_truthy
  end
end
