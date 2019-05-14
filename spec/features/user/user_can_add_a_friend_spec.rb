require 'rails_helper'

describe 'as a logged in User with github connected' do
  # before :each do
  #   @user = User.find_by(email: 'user@example.com')
  #   @user_2 = User.find_by(email: 'user2@example.com')
  # end
  # VCR.use_cassette("/services/add_a_friend") do
  #   it 'I can add a follower as a friend' do
  #     allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
  #
  #     visit dashboard_path
  #
  #     expect(page).to have_content("Followers")
  #     expect(page).to have_css(".follower")
  #
  #     within first ".follower" do
  #       expect(page). to have_link("jaxtestingaccount")
  #       expect(page). to have_link("Add as friend")
  #       click_link("Add as friend")
  #     end
  #   end
  # end
end
