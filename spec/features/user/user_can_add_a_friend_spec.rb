require 'rails_helper'

RSpec.describe 'User can see a adda friend for possible friendships' do
  describe 'As a logged in user, when I visit my dashboard' do
    before :each do
      @user1 = create(:user, uid: '12')
      create(:github_token, user: @user1, token: ENV['USER_1_GITHUB_TOKEN'])

      @user2 = create(:user, uid: '34')

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user1)

      stub_user_1_dashboard
    end

    it "I can see 'add a friend' button" do
      visit '/dashboard'

      expect(page).to have_content("My Followers")

      within(page.all('.user_follower')[0]) do
        expect(page).to have_link('Mackenzie-Frey', href: "https://github.com/Mackenzie-Frey")
        expect(page).to_not have_css('.friend-button')
      end

      within(page.all('.user_follower')[1]) do
        expect(page).to have_link('Zach-Nager', href: "https://github.com/nagerz")
        expect(page).to have_css('.friend-button', count: 1)
        expect(page).to have_button('Add as a Friend')
      end
    end

    it "I can see a freindships section with no friends" do
      visit '/dashboard'

      within('.user-friendships') do
        expect(page).to have_content("You have not friended anyone yet.")
      end
    end

    it 'I can click button and add a friend' do
      visit '/dashboard'

      within(page.all('.user_follower')[1]) do
        click_button("Add as a Friend")
      end

      expect(current_path).to eq(dashboard_path)
      expect(page).to have_content("#{@user2.first_name} added as a friend.")

      within('.user-friendships') do
        expect(page).to have_css('.friend', count: 1)
        expect(page).to have_content("#{@user2.first_name} #{@user2.last_name}")
      end
    end

    it 'After adding a friend, I no longer see button' do
      visit '/dashboard'

      within(page.all('.user_follower')[1]) do
        click_button("Add as a Friend")
      end

      expect(current_path).to eq(dashboard_path)
      expect(page).to have_content("#{@user2.first_name} added as a friend.")

      within(page.all('.user_follower')[1]) do
        expect(page).to_not have_css('.friend-button')
      end
    end
  end
end
