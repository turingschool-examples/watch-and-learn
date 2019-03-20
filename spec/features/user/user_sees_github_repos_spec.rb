require 'rails_helper'

describe "A registered user" do
  it "sees 5 Github repos on profile" do
    user = create(:user, email: "test@email.com", password: "test")
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    VCR.use_cassette("services/get_repos") do
      visit dashboard_path

      within ".user_github" do
        expect(page).to have_content("GitHub")
        expect(page).to have_content("activerecord-obstacle-course")
        expect(page).to have_css(".name", count: 5)
      end
    end
  end
end
