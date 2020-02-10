require 'rails_helper'

RSpec.describe 'As a user connected to github' do
  describe 'when i visit my dashboard', :vcr do
    before :each do
      @user_1 = create :user, github_token: ENV['GITHUB_TOKEN'], github_id: '123456'
      @user_2 = create :user, github_id: '52684225', first_name: 'Matt', last_name: 'Simon'
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user_1)

      visit '/dashboard'
    end

    describe 'has button to add friend' do
      it 'has button to add friend next to user#2' do
        within("#follower-#{@user_2.github_id}") do
          expect(page).to have_button('Add Friend')
        end

        within("#followee-#{@user_2.github_id}") do
          expect(page).to have_button('Add Friend')
        end
      end

      it 'does not have button if follower/followee is not in our system' do
        within("#follower-53122061") do
          expect(page).to_not have_button('Add Friend')
        end

        within("#followee-53122061") do
          expect(page).to_not have_button('Add Friend')
        end
      end
    end

    describe 'when i click on the add friend button' do
      it 'will add the user to my friends list' do
        within("#follower-#{@user_2.github_id}") do
          click_button 'Add Friend'
        end

        expect(current_path).to eq('/dashboard')

        within(".friends") do
          expect(page).to have_content('Matt Simon')
        end
      end
    end
  end
end
