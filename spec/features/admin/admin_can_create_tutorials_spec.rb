require 'rails_helper'

RSpec.describe "An admin can add tutorials" do
  it "#create tutorial" do
    admin = create(:user, role: 1)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit "admin/dashboard"
    click_on "New Tutorial"

    expect(current_path).to eq(new_admin_tutorial_path)

    fill_in "tutorial[title]", with: "How to use ActionMailer"
    fill_in "tutorial[description]", with: "Like a boss"
    fill_in "tutorial[thumbnail]", with: "https://i.ytimg.com/vi/qMkRHW9zE1c/hqdefault.jpg"
    click_on "Save"

    expect(page).to have_content("The tutorial has been created")
    expect(current_path).to eq(new_admin_tutorial_video_path(Tutorial.last))
  end
end