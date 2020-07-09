require 'rails_helper'

feature "An admin can delete a tutorial" do
  scenario "and it should no longer exist" do
    admin = create(:admin)
    create_list(:tutorial, 2)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit "/admin/dashboard"

    expect(page).to have_css('.admin-tutorial-card', count: 2)

    within(first('.admin-tutorial-card')) do
      click_on 'Delete'
    end

    expect(page).to have_css('.admin-tutorial-card', count: 1)
  end

  it "deleted videos associated with the tutorial" do
    admin = create(:admin)

    tutorial1 = create(:tutorial)
    tutorial2 = create(:tutorial)

    video1 = create(:video, tutorial_id: tutorial1.id)
    video2 = create(:video, tutorial_id: tutorial1.id)
    video3 = create(:video, tutorial_id: tutorial2.id)
    video4 = create(:video, tutorial_id: tutorial2.id)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit "/admin/dashboard"

    within(first('.admin-tutorial-card')) do
      click_on 'Delete'
    end

    videos = Video.all

    expect(videos.length).to eq(2)
  end

end
