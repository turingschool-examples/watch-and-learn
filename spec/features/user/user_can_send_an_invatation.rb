require 'rails_helper'

Rspec.describe "As a user", type: :feature do
  before :each do
    user = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit dashboard_path
    click_on "Send an invitation"

    expect(current_path).to eq(send_invitation_path)
  end

  it "#can send an invitation" do
    fill_in "Github Handle", with: "Bozotte"
    click_on "Send Invitation"

    expect(current_path).to eq(dashboard_path)

    expect(page).to have_content("Successfully sent invite!")
    expect(page).to_not have_content("The user you selected doesn't have an email associated with their account.")
  end

  it "#can't send an invitation" do
    fill_in "Github Handle", with: "hola"
    click_on "Send Invitation"

    expect(current_path).to eq(dashboard_path)

    expect(page).to_not have_content("Successfully sent invite!")
    expect(page).to have_content("The user you selected doesn't have an email associated with their account.")
  end
end