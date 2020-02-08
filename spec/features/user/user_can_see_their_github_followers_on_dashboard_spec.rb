require 'rails_helper'

describe "as a logged in user", :vcr do
  it "can see its github followers" do
    user = create(:user, token: ENV['GITHUB_TOKEN'])

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit '/dashboard'

    within ".github" do
      expect(page).to have_content("Followers")
      expect(page).to have_css(".followers", count: 3)
    end

    within first(".followers") do
      expect(page).to have_link("jfangonilo")
    end
  end
end
