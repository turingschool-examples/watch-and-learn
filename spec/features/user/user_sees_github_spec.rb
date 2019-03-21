require 'rails_helper'

describe "A registered user" do
  it "sees 5 GitHub repos on profile", :vcr do
    user = create(:user, email: "test@email.com", password: "test", github_token: ENV['GITHUB_API_KEY'])
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit dashboard_path

    within ".user_github" do
      expect(page).to have_content("GitHub")
      within ".user_github_repos" do
        expect(page).to have_content("Repositories")
        expect(page).to have_content("activerecord-obstacle-course")
        expect(page).to have_css(".name", count: 5)
      end
    end
  end

  it "sees only their own repos when other users have tokens", :vcr do
    user = create(:user, email: "mackenzie@email.com", password: "test", github_token: ENV['MF_GITHUB_TOKEN'])
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit dashboard_path

    within ".user_github" do
      expect(page).to have_content("GitHub")
      within ".user_github_repos" do
        expect(page).to have_content("election")
        expect(page).to have_content("little_shop")
        expect(page).to have_content("thirsty_plants")
        expect(page).to have_content("activerecord-obstacle-course")
        expect(page).to have_content("alt_fuel_finder")
        expect(page).to have_css(".name", count: 5)
      end
    end
  end

  context "who doesn't have a token" do
    it "does not see the Github section" do
      user = create(:user, email: "test@email.com", password: "test")
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit dashboard_path

      expect(page).to_not have_css(".user_github")
      expect(page).to_not have_content("Repositories")
      expect(page).to_not have_css(".user_github_followers")
      expect(page).to_not have_content("Followers")
      expect(page).to_not have_css(".follower")
      expect(page).to_not have_css(".follower_handle")
    end
  end

  it 'sees followers section on profile', :vcr do
    user = create(:user, email: "test@email.com", password: "test", github_token: ENV['GITHUB_API_KEY'])

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit dashboard_path

    within ".user_github" do
      expect(page).to have_content("GitHub")
      within ".user_github_followers" do
        expect(page).to have_content("Followers")
        expect(page).to have_css(".follower", count: 5)
        expect(page).to have_css(".follower_handle", count: 5)
        expect(page).to have_link("nagerz")
      end
    end
  end

  it 'sees following section on profile', :vcr do
    user = create(:user, email: "test@email.com", password: "test", github_token: ENV['GITHUB_API_KEY'])

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit dashboard_path

    within ".user_github" do
      expect(page).to have_content("GitHub")
      within ".user_github_following" do
        expect(page).to have_content("Following")
        expect(page).to have_css(".following", count: 5)
        expect(page).to have_css(".following_handle", count: 5)
        expect(page).to have_link("nagerz")
      end
    end
  end
end
