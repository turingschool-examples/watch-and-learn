require 'rails_helper'

describe "As a user can see github repos" do
  it "on their dashboard", :vcr do
  token = ENV["GITHUB_TOKEN_LOCAL"]
  user = create(:user, token: token)

  allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit dashboard_path

    expect(current_path).to eq(dashboard_path)
    expect(page).to have_css(".repos", count: 5)
    within(first(".repos")) do
      expect(page).to have_css(".name")
    end

    expect(page).to have_css(".following", count: 5)
    within(first(".following")) do
      expect(page).to have_css(".name")
    end

    click_on "Log Out"

    expect(page).not_to have_css(".repos")
    expect(page).not_to have_css(".following")
  end
end
