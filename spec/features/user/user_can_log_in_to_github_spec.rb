require 'rails_helper'

describe "As a logged in user" do
  it "can authenticate with Github", :vcr do
    user = create(:user)
    # allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit login_path
    fill_in "session[email]", with: user.email
    fill_in "session[password]", with: user.password
    click_on "Log In"
    visit dashboard_path

    expect(page).to have_link("Connect to Github")
    expect(page).to_not have_css(".repo")
    expect(page).to_not have_css(".follower")
    expect(page).to_not have_css(".following")

    user.update_column(:access_token, ENV["GITHUB_TOKEN_KEY"])

    visit dashboard_path

    expect(page).to_not have_link("Connect to Github")
    expect(page).to have_css(".repo")
    expect(page).to have_css(".follower")
    expect(page).to have_css(".following")
  end
end
