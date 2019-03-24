require 'rails_helper'

describe 'As a user' do
  describe 'I can add friends in the system' do
    before :each do
      @user = create(:github_user)
      @potential_friend = create(:github_user, uid: 41562392)
      @current_friend = create(:github_user)
      current_friend_1 = Friend.create(user: @user, friend_user: @current_friend)
      current_friend_2 = Friend.create(user: @current_friend, friend_user: @user)
    end

    it 'next to my github follwers who have accounts I see a a button to add as a friend' do
      allow_any_instance_of(ApplicationController).to(
        receive(:current_user).and_return(@user))

      VCR.use_cassette('views/dashboard_github_request') do
        visit dashboard_path

        within "#follower-#{@potential_friend.uid}" do
          expect(page).to have_button 'Add as Friend'
        end
      end
    end

    it 'I also see a button next to my follwed users' do
      allow_any_instance_of(ApplicationController).to(
        receive(:current_user).and_return(@user))

      VCR.use_cassette('views/dashboard_github_request') do
        visit dashboard_path

        within "#following-#{@potential_friend.uid}" do
          expect(page).to have_button 'Add as Friend'
        end
      end
    end

    it 'I do not see a button next to follwers without accounts' do
      allow_any_instance_of(ApplicationController).to(
        receive(:current_user).and_return(@user))

      VCR.use_cassette('views/dashboard_github_request') do
        visit dashboard_path

        within "#follower-13354855" do
          expect(page).to_not have_button 'Add as Friend'
        end
      end
    end

    it 'I do not see a button next to followed users without accounts' do
      allow_any_instance_of(ApplicationController).to(
        receive(:current_user).and_return(@user))

      VCR.use_cassette('views/dashboard_github_request') do
        visit dashboard_path

        within "#following-13354855" do
          expect(page).to_not have_button 'Add as Friend'
        end
      end
    end

    it 'I see a section for friends on my dashboard if I have friends' do
      allow_any_instance_of(ApplicationController).to(
        receive(:current_user).and_return(@user))

      VCR.use_cassette('views/dashboard_github_request') do
        visit dashboard_path

        expected = @current_friend.first_name + ' ' + @current_friend.last_name

        expect(page).to have_css '.friends'
        within '.friends' do
          expect(page).to have_content(expected)
        end
      end
    end

    it 'I do not see friends when I have no friends' do
      allow_any_instance_of(ApplicationController).to(
        receive(:current_user).and_return(@potential_friend))

      expected = @current_friend.first_name + ' ' + @current_friend.last_name

      VCR.use_cassette('views/dashboard_github_request') do
        visit dashboard_path

        expect(page).to have_css '.friends'
        within '.friends' do
          expect(page).to_not have_content(expected)
          expect(page).to have_content("You currently have no friends ;_;")
          expect(page).to have_content("Look through your followers and go add some!")
        end
      end
    end

    it 'I can click this button to add a user as a friend' do
      allow_any_instance_of(ApplicationController).to(
        receive(:current_user).and_return(@user))

      VCR.use_cassette('views/dashboard_github_request') do
        visit dashboard_path

        within "#follower-#{@potential_friend.uid}" do
          click_button 'Add as Friend'
        end

        expect(current_path).to eq(dashboard_path)

        within "#follower-#{@potential_friend.uid}" do
          expect(page).to_not have_button 'Add as Friend'
        end
      end
    end

    it 'I see a section for pending friend requests on my dashbard' do
      allow_any_instance_of(ApplicationController).to(
        receive(:current_user).and_return(@potential_friend))
      potential_friendship = Friend.create(user: @user, friend_user: @potential_friend)

      expected = @user.first_name + ' ' + @user.last_name

      VCR.use_cassette('views/dashboard_github_request') do
        visit dashboard_path

        expect(current_path).to eq(dashboard_path)

        within '.friend_requests' do
          expect(page).to have_content expected
          expect(page).to have_button 'Accept'
          expect(page).to have_button 'Decline'
        end
      end
    end

    it 'I can accept pending requests' do
      allow_any_instance_of(ApplicationController).to(
        receive(:current_user).and_return(@potential_friend))
      potential_friendship = Friend.create(user: @user, friend_user: @potential_friend)

      expected = @user.first_name + ' ' + @user.last_name

      VCR.use_cassette('views/dashboard_github_request') do
        visit dashboard_path

        expect(current_path).to eq(dashboard_path)

        within '.friend_requests' do
          click_button 'Accept'
        end

        expect(current_path).to eq(dashboard_path)

        within '.friends' do
          expect(page).to have_content expected
        end

        within '.friend_requests' do
          expect(page).to_not have_content expected
        end
      end
    end

    it 'I can decline pending requests' do
      allow_any_instance_of(ApplicationController).to(
        receive(:current_user).and_return(@potential_friend))
      potential_friendship = Friend.create(user: @user, friend_user: @potential_friend)

      expected = @user.first_name + ' ' + @user.last_name

      VCR.use_cassette('views/dashboard_github_request') do
        visit dashboard_path

        expect(current_path).to eq(dashboard_path)

        within '.friend_requests' do
          click_button 'Decline'
        end

        expect(current_path).to eq(dashboard_path)

        within '.friends' do
          expect(page).to_not have_content expected
        end

        within '.friend_requests' do
          expect(page).to_not have_content expected
        end
      end
    end
  end
end
