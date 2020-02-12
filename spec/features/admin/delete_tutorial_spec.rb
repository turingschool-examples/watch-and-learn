require 'rails_helper'

describe "An Admin can edit a tutorial" do
  let(:admin)    { create(:admin) }

  scenario "by adding a video", :js, :vcr do
    admin = create(:user, role: 1)
    tutorial = create(:tutorial)
    video1 = create(:video, tutorial_id: tutorial.id)
    video2 = create(:video, tutorial_id: tutorial.id)
    video3 = create(:video, tutorial_id: tutorial.id)

    tutorial2 = create(:tutorial)
    video4 = create(:video, tutorial_id: tutorial2.id)
    video5 = create(:video, tutorial_id: tutorial2.id)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit admin_dashboard_path

    within(first(".admin-tutorial-card")) do
      expect(page).to have_content(tutorial.title)
      click_on "Destroy"
    end
    expect(current_path).to eq(admin_dashboard_path)
    within(".admin-tutorial-card") do
      expect(page).not_to have_content(tutorial.title)
    end
  end
end
