require 'rails_helper'

describe "As a user", :vcr do

  before :each do
    user = create(:user)
    user.user_credentials.create!(token: ENV["GITHUB-API-KEY"], nickname: "TheMindset", website: "github")

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit dashboard_path
    click_on "Send an invitation"

    expect(current_path).to eq(send_invitation_path)
  end

  it "#can send an invitation" do
    fill_in "Github Handle", with: "TheMindset"
    click_on "Send the invitation"

    expect(current_path).to eq(dashboard_path)

    expect(page).to have_content("The user you selected doesn't have an email associated with their account.")
  end

  it "#can't send an invitation" do
    fill_in "Github Handle", with: "dzescgr"
    click_on "Send the invitation"

    expect(current_path).to eq(dashboard_path)

    expect(page).to have_content("Github user not found")
    expect(page).to_not have_content("Successfully sent the invitation!")
    expect(page).to_not have_content("The user you selected doesn't have an email associated with their account.")
  end
end