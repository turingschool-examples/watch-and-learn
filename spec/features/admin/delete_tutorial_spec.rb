require 'rails_helper'

describe "As an admin on the admin dashboard" do
  it "can delete tutorials, and all related videos are deleted" do
    admin = create(:user, role: 1)
    tutorial = create(:tutorial)
    video_1 = create(:video, tutorial_id: tutorial.id)
    video_2 = create(:video, tutorial_id: tutorial.id)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit admin_dashboard_path

    expect(page).to have_content(tutorial.title)
    expect(Video.pluck(:id)).to eq([video_1.id, video_2.id])

    within(first(".admin-tutorial-card")) do
      click_button "Destroy"
    end

    expect(current_path).to eq(admin_dashboard_path)
    expect(page).to_not have_content(tutorial.title)
    expect(Video.pluck(:id)).to eq([])
  end
end
