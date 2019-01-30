require 'rails_helper'

describe "Users and Followers" do
  it 'can see followers' do
    user = create(:user, token: ENV["GITHUB_API_KEY"])
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit "/dashboard"

    within(".github") do
      expect(page).to have_content("Followers")
      expect(page).to have_css(".follower")
      within(all(".follower").first) do
        expect(page).to have_content("Username")
      end
    end
  end
  it 'can those you are following' do
    user = create(:user, token: ENV["GITHUB_API_KEY"])
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit "/dashboard"

    within(".github") do
      expect(page).to have_content("Following")
      expect(page).to have_css(".following")
      within(all(".followee").first) do
        expect(page).to have_content("Username")
      end
    end
  end
end
