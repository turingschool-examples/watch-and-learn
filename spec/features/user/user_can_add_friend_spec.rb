require 'rails_helper'

describe 'A registered user' do
  context 'visiting /dashboard' do
    it 'can add followers or followings that have linked their account to github as friends' do
      user = create(:user, github_token: ENV["github_key"])
      user1 = create(:user, uid: 25069483, first_name: 'TestName')

      mock_user_dashboard_github

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit dashboard_path

      expect(user.friends).to eq([])
      expect(page).to have_content('Friends')
      within ".friends" do
        expect(page).to_not have_content(user1.first_name)
      end

      within ".followers" do
        click_button('Add Friend')
      end

      expect(current_path).to eq(dashboard_path)
      expect(user.friends[0]).to be_a(User)
      within ".friends" do
        expect(page).to have_content(user1.first_name)
      end
    end
  end
end
