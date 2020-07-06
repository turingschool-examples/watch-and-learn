require 'rails_helper'

feature "An admin can delete a tutorial" do
  scenario "and it should no longer exist" do
    admin = create(:admin)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    tutorial1 = create(:tutorial)
    tutorial2 = create(:tutorial)

    create(:video, tutorial_id: tutorial1.id)
    create(:video, tutorial_id: tutorial1.id)
    create(:video, tutorial_id: tutorial1.id)
    create(:video, tutorial_id: tutorial2.id)
    create(:video, tutorial_id: tutorial2.id)
    
    expect(tutorial1.videos.count).to eq(3)
    expect(tutorial2.videos.count).to eq(2)

    expect(Video.all.count).to eq(5)

    visit "/admin/dashboard"

    expect(page).to have_css('.admin-tutorial-card', count: 2)

    within(first('.admin-tutorial-card')) do
      click_link 'Delete'
    end

    expect(page).to have_css('.admin-tutorial-card', count: 1)
    expect(tutorial2.videos.count).to eq(2)
    expect(Video.all.count).to eq(2)
  end
end
