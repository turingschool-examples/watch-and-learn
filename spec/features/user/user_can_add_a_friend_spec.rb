require 'rails_helper'

describe 'as a logged in User with github connected' do
  before :each do
    @user_1 = create(:user, github_id: 2)
    @user_2 = create(:user, github_id: 1)
  end
    it 'I can add a follower as a friend' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

      visit dashboard_path

      expect(page).to have_content("Followers")
      expect(page).to have_css(".follower")

      within first ".follower" do
        expect(page).to have_link("jaxtestingaccount")
        expect(page).to have_link("Add as friend")
        click_button("Add as friend")
      end
    end
end
