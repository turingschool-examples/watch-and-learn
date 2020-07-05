require 'rails_helper'

feature "An admin can delete a tutorial" do
  before :each do
    @admin = create(:admin)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
  end
  scenario "and it should no longer exist" do
    create_list(:tutorial, 2)

    visit "/admin/dashboard"

    expect(page).to have_css('.admin-tutorial-card', count: 2)

    within(first('.admin-tutorial-card')) do
      click_link 'Delete'
    end

    expect(page).to have_css('.admin-tutorial-card', count: 1)
  end

  scenario "and it removes videos as well" do
    tutorial_1 = create(:tutorial)
    video = create(:video, tutorial_id: tutorial_1.id)

    visit "/admin/dashboard"

    within(first('.admin-tutorial-card')) do
      click_link 'Delete'
    end
    expect(Tutorial.all).to not_have(tutorial_1)
    expect(Video.all).to not_have(video)
  end
end
