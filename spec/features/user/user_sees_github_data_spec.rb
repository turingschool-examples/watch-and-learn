require 'rails_helper'

describe 'User' do
  describe "When I visit my dashboard", :vcr do
    before(:each) do
      @user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      visit dashboard_path
    end

    it "I see a Connect to Github button if not connected" do
      expect(page).to have_button("Connect to Github")
    end

    it 'can connect with Github OAuth and see 5 repos' do
      click_button "Connect to Github"

      expect(page.status_code).to eq(200)
      expect(current_path).to eq(dashboard_path)
      expect(page).to have_content('Repositories')
      within("#repositories") do
        expect(page).to have_link(count: 5)
      end
    end

    it "can see all github followers" do
      click_button "Connect to Github"

      expect(page).to have_content('Followers')
      within("#followers") do
        expect(page).to have_css('.github-follower')
      end
    end

    it "can see all github users that the current user is following" do
      click_button "Connect to Github"

      expect(page).to have_content('Following')
      within("#following") do
        expect(page).to have_css('.github-following')
      end
    end

    it "sees notifications for lack of github content" do
      @user_2 = create(:user, token: ENV['EMPTY_USER_TOKEN'])
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user_2)
      visit dashboard_path

      expect(page).to have_content('Repositories')
      expect(page).to have_content('Followers')
      expect(page).to have_content('Following')
      within('#repositories') do
        expect(page).to have_content("You don't have any Github repositories")
      end
      within('#followers') do
        expect(page).to have_content("You don't have any Github followers")
      end
      within('#following') do
        expect(page).to have_content("You aren't following anyone on Github")
      end
    end
  end
end
