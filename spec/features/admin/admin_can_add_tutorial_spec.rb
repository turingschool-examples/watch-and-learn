require "rails_helper"

context "As a logged-in admin" do
  it "can successfully add a tutorial" do
    admin = create(:admin)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit admin_dashboard_path
    click_link "New Tutorial"
    expect(current_path).to eq(new_admin_tutorial_path)

    fill_in "tutorial[title]", with: "Test"
    fill_in "tutorial[description]", with: "Stuff"
    fill_in "tutorial[thumbnail]", with: "https://youtu.be/J7ikFUlkP_k"
    click_button "Save"

    expect(current_path).to eq(admin_dashboard_path)

    expect(page).to have_content("Test")
  end


end
