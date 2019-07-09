require "rails_helper"

describe "As a user on dashboard path" do
  before :each do
    @user = create(:user)
    @user.update(html_url: "https://github.com/cjbrambo")
    @user.token = Token.new(github_token: ENV["GITHUB_API_KEY"])
    @user_2 = create(:user)
    @user_2.update(html_url: "https://github.com/Mycobee")
    @user_2.token = Token.new(github_token: ENV["GITHUB_API_KEY_2"])
  end

  scenario "Links show up next to followers that have accounts in our system." do
    VCR.use_cassette("github/dashboard_rob", :allow_playback_repeats => true) do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user_2)
      visit dashboard_path
      within(".github_followers_section") do
        expect(page).to have_button("Add to Friends")
      end
    end
  end

  scenario "Links show up next to following that have accounts in our system." do
    VCR.use_cassette("github/dashboard_chris", :allow_playback_repeats => true) do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      visit dashboard_path
      within(".github_following_section") do
        expect(page).to have_button("Add to Friends")
      end
    end
  end

  scenario "Adds to friendships when clicked and updates friend list" do
    VCR.use_cassette("github/dashboard_chris", :allow_playback_repeats => true) do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      visit dashboard_path
      within(".github_following_section") do
        click_button("Add to Friends")
      end
      expect(current_path).to eq(dashboard_path)
      @user.reload
      friend = User.find(@user.friendships.first.friend_id)
      expect(friend).to eq(@user_2)
      within(".github_friend_list") do
        expect(page).to have_content(@user_2.first_name)
      end
    end
  end
end
