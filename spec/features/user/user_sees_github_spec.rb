require 'rails_helper'

describe "A registered user" do
  it "sees 5 Github repos on profile", :vcr do
    user = create(:user, email: "test@email.com", password: "test", github_token: ENV['GITHUB_API_KEY'])
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit dashboard_path

    within ".user_github" do
      expect(page).to have_content("GitHub")
      expect(page).to have_content("activerecord-obstacle-course")
      expect(page).to have_css(".name", count: 5)
    end
  end

  it "sees only their own repos when other uses have tokens", :vcr do
    user = create(:user, email: "mackenzie@email.com", password: "test", github_token: ENV['MF_GITHUB_TOKEN'])
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit dashboard_path

    within ".user_github" do
      expect(page).to have_content("GitHub")
      expect(page).to have_content("election")
      expect(page).to have_content("little_shop")
      expect(page).to have_content("thirsty_plants")
      expect(page).to have_content("activerecord-obstacle-course")
      expect(page).to have_content("alt_fuel_finder")
      expect(page).to have_css(".name", count: 5)
    end
  end

  context "who doesn't have a token" do
    it "does not see the Github section" do
      user = create(:user, email: "test@email.com", password: "test")
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit dashboard_path

      expect(page).to_not have_css(".user_github")
    end
  end
end
