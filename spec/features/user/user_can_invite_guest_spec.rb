require 'rails_helper'

# As a registered user
# When I visit /dashboard
# And I click "Send an Invite"
# Then I should be on /invite
#
# And when I fill in "Github Handle" with <A VALID GITHUB HANDLE>
# And I click on "Send Invite"
# Then I should be on /dashboard
# And I should see a message that says "Successfully sent invite!" (if the user has an email address associated with their github account)
# Or I should see a message that says "The Github user you selected doesn't have an email address associated with their account."
#

describe "invite guest" do
  it "can invite guest using github handle" do
    user = create(:user, github_id: 123, github_token: ENV["GITHUB_API_KEY"])

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit dashboard_path

    click_link "Send an Invite"

    expect(current_path).to eq(invite_path)

    fill_in "GitHub Handle", with: "mackhalliday"

    click_on "Send Invite"

    expect(current_path).to eq(dashboard_path)

    expect(page).to have_content("Successfully sent invite!")
  end

  it "invited guest does not have email associated with github" do

    user = create(:user, github_id: 123, github_token: ENV["GITHUB_API_KEY"])

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit dashboard_path

    click_link "Send an Invite"

    expect(current_path).to eq(invite_path)

    fill_in "GitHub Handle", with: "alect47"

    click_on "Send Invite"

    expect(current_path).to eq(dashboard_path)

    expect(page).to have_content("The Github user you selected doesn't have an email address associated with their account.")
  end

  it "searched github handle does not exist" do
    
    user = create(:user, github_id: 123, github_token: ENV["GITHUB_API_KEY"])

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit dashboard_path

    click_link "Send an Invite"

    expect(current_path).to eq(invite_path)

    fill_in "GitHub Handle", with: "alect4777777777777"

    click_on "Send Invite"

    expect(current_path).to eq(invite_path)

    expect(page).to have_content("The GitHub username you have entered is invalid.")
  end
end
