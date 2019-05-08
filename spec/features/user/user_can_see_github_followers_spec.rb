require 'rails_helper'

describe 'as a logged in user on my dashboard' do
  before :each do
    @user = create(:user, github_token: ENV["GITHUB_API_KEY"])
    @user_without_token = create(:user)
  end

  it 'User with github_token can see github followers' do
    VCR.use_cassette("services/find_followers") do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      visit dashboard_path

      expect(page).to have_content("Followers")
      expect(page).to have_css(".follower")

      within first ".follower" do
        expect(page). to have_link("chitasan")
      end
    end
  end
end 