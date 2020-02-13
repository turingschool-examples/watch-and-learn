require 'rails_helper'

describe "An Admin can edit a tutorial" do
  it "by adding a video", :js, :vcr do
    user = create(:admin)
    tutorial = create(:tutorial)
    create(:tutorial)
    create(:video, tutorial_id: tutorial.id)
    create(:video, tutorial_id: tutorial.id)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    expect(Tutorial.all.count).to eq(2)
    expect(Video.all.count).to eq(2)

    visit "/admin/dashboard"

    within first('#buttons') do
      click_button 'Destroy'
    end

    expect(current_path).to eq("/admin/dashboard")
    expect(page).to have_content("Tutorial and related videos deleted.")

    expect(Tutorial.all.count).to eq(1)
    expect(Video.all.count).to eq(0)
  end
end
