require 'rails_helper'

describe "As a registered user connected to Github" do
  before :each do
    @april = create(:user, email: "test@email.com", password: "test", github_token: ENV['GITHUB_API_KEY'], github_uid: "41272635", github_handle: 'aprildagonese', github_url: 'https://github.com/aprildagonese')
    @mackenzie = create(:user, email: "mackenzie@email.com", password: "test", github_token: ENV['MF_GITHUB_TOKEN'], github_uid: "42525195", github_handle: 'Mackenzie-Frey', github_url: 'https://github.com/Mackenzie-Frey')
    @zach = create(:user, email: "zach@email.com", password: "test", github_token: "faketoken", github_uid: "34927114", github_handle: 'nagerz', github_url: 'https://github.com/nagerz')

    repos_json_response = File.open('fixtures/user_repos.rb')
    stub_request(:get, "https://api.github.com/user/repos").to_return(status: 200, body: repos_json_response)

    followers_json_response = File.open('fixtures/user_followers.rb')
    stub_request(:get, "https://api.github.com/user/followers").to_return(status: 200, body: followers_json_response)

    following_json_response = File.open('fixtures/user_following.rb')
    stub_request(:get, "https://api.github.com/user/following").to_return(status: 200, body: following_json_response)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@april)

  end

  context "when my followers/following is also connected to Github" do
    it "I see a button to add them as a friend" do
      visit dashboard_path
      #Following section
      within ".following_handle_unrealities" do
        expect(page).to_not have_button("Add Friend")
      end
      within ".following_handle_teresa-m-knowles" do
        expect(page).to_not have_button("Add Friend")
      end
      within ".following_handle_nagerz" do
        expect(page).to have_button("Add Friend")
      end
      within ".following_handle_PeregrineReed" do
        expect(page).to_not have_button("Add Friend")
      end
      within ".following_handle_plapicola" do
        expect(page).to_not have_button("Add Friend")
      end

      #Follower section
      within ".follower_handle_nagerz" do
        expect(page).to have_button("Add Friend")
      end
      within ".follower_handle_Mackenzie-Frey" do
        expect(page).to have_button("Add Friend")
      end
      within ".follower_handle_MaryBork" do
        expect(page).to_not have_button("Add Friend")
      end
      within ".follower_handle_TyMazey" do
        expect(page).to_not have_button("Add Friend")
      end
      within ".follower_handle_plapicola" do
        expect(page).to_not have_button("Add Friend")
      end
    end
  end

  context "when I click on 'Add Friend'" do
    it "I see my friends under My Friends" do
      visit dashboard_path

      expect(page).to_not have_css(".my_friends")
      expect(page).to_not have_content("My Friends")
      expect(page).to_not have_css(".friend")
      expect(page).to_not have_css(".friend_handle_nagerz")

      within ".following_handle_nagerz" do
        click_button("Add Friend")
      end

      within ".my_friends" do
        expect(page).to have_content("My Friends")
        expect(page).to have_css(".friend")
        expect(page).to have_css(".friend_handle_nagerz")
        expect(page).to have_link("nagerz")
      end
    end

    it "I see my friends under My Friends" do
      visit dashboard_path

      expect(page).to_not have_css(".my_friends")
      expect(page).to_not have_content("My Friends")
      expect(page).to_not have_css(".friend")
      expect(page).to_not have_css(".friend_handle_nagerz")

      within ".following_handle_nagerz" do
        click_button("Add Friend")
      end

      within ".my_friends" do
        expect(page).to have_content("My Friends")
        expect(page).to have_css(".friend")
        expect(page).to have_css(".friend_handle_nagerz")
        expect(page).to have_link("nagerz")
      end
    end
  end
end
