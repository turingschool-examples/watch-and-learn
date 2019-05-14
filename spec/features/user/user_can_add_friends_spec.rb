require 'rails_helper'

RSpec.describe "as a logged in user that has linked a github" do
  context "when I visit my dashboard" do
    it "can add other users who have linked their github as friends from their followers and followed", :vcr do
      user = create(:user)
      binding.pry
      friend_user = create(:user, github_name: 'tnodland', token: ENV['GITHUB_FRIEND_TOKEN'])
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit dashboard_path

      within '.following' do
        expect(page.all('.li').first).to_not have_link("Add as Friend")
        expect(page.all('.li').last).to have_link("Add as Friend")
      end

      within '.followers' do
        expect(page.all('.li').first).to_not have_link("Add as Friend")
        expect(page.all('.li').last).to have_link("Add as Friend")
      end
    end
  end
end
