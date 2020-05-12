require 'rails_helper'

feature "An admin can delete a tutorial", :vcr do
  before :each do
    admin = create(:admin)
    @tutorial = create(:tutorial)
    create_list(:tutorial, 2)
    @video1 = create(:video, tutorial_id: @tutorial.id)
    @video2 = create(:video, tutorial_id: @tutorial.id)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
    visit "/admin/dashboard"
  end

  scenario "and it should no longer exist" do
    expect(page).to have_css('.admin-tutorial-card', count: 3)

    within(first('.admin-tutorial-card')) do
      click_link 'Delete'
    end

    expect(page).to have_css('.admin-tutorial-card', count: 2)
  end

  scenario "and it's associated videos are deleted as well." do
    expect(page).to have_css('.admin-tutorial-card', count: 3)

    within(first('.admin-tutorial-card')) do
      click_link('Delete')
    end

    expect(page).to have_css('.admin-tutorial-card', count: 2)
    expect(@tutorial.videos).to eq([])
    expect(@video1.nil?).to eq(false)
  end
end
