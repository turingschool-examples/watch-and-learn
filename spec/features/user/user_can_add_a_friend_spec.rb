require 'rails_helper'

describe 'as a logged in User with github connected' do
  before :each do
    @user = create(:user, github_token: ENV["GITHUB_API_KEY"], github_id: 40487417)
    @friend_user = create(:user, github_id: 44073660)
  end
    it 'I can add a follower as a friend' do
      VCR.use_cassette("services/find_followers") do
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

        visit dashboard_path

        expect(page).to have_content("Followers")
        expect(page).to have_css(".follower")

        within first ".follower" do
          expect(page).to have_link("chitasan")
          expect(page).to have_button("Add as Friend")
        end
      end
    end

    it 'I cannot add a follower as a friend if already friended' do
      VCR.use_cassette("services/find_followers") do
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

        Friendship.create!(user_id: @user.id, friended_user_id: @friend_user.id)

        visit dashboard_path

        expect(page).to have_content("Followers")
        expect(page).to have_css(".follower")

        within first ".follower" do
          expect(page).to have_link("chitasan")
          expect(page).to_not have_button("Add as Friend")
        end
      end
    end

end
