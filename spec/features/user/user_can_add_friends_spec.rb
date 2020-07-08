require 'rails_helper'

describe 'As a registered user' do
  describe 'When I visit the dashboard' do
    it 'I see a link to add as friend next to github followers/followings' do
      user1 = create(:user, token:  ENV["GITHUB_API_TOKEN_R"])
      user2 = create(:user, token:  ENV["GITHUB_API_TOKEN"], username: 'takeller')

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user1)

      visit '/dashboard'

      within(".following-#{user2.username}") do
        expect(page).to have_link('Add as Friend', :href => "/users/#{user1.id}/friendships?friend_username=#{user2.username}")
      end

      within(".follower-#{user2.username}") do
        expect(page).to have_link('Add as Friend', :href => "/users/#{user1.id}/friendships?friend_username=#{user2.username}")
      end
    end

    it 'When I click the Add as Friend link, I create a friendship with that user' do
      user1 = create(:user, token:  ENV["GITHUB_API_TOKEN_R"])
      user2 = create(:user, token:  ENV["GITHUB_API_TOKEN"], username: 'takeller')

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user1)

      visit '/dashboard'

      expect(user1.friends.size).to eq(0)
      expect(user2.friends.size).to eq(0)

      within(".following-#{user2.username}") do
        click_on 'Add as Friend'
      end

      expect(current_path).to eq('/dashboard')
      expect(user1.reload.friends.size).to eq(1)
      expect(user1.reload.friends.first).to eq(user2)
      expect(user2.reload.friends.size).to eq(0)
    end

    it 'I do not see an Add as Friend link, if that follower/following is not registered on the website' do
      user1 = create(:user, token:  ENV["GITHUB_API_TOKEN_R"])
      user2 = create(:user, token:  ENV["GITHUB_API_TOKEN"])


      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user1)

      visit '/dashboard'

      within('#github-following') do
        expect(page).to_not have_content("Add as Friend")
      end

      within('#github-followers') do
        expect(page).to_not have_content("Add as Friend")
      end
    end

    it 'I see all of my friends listed on the dashboard' do
      user1 = create(:user, token:  ENV["GITHUB_API_TOKEN_R"])
      user2 = create(:user)
      user3 = create(:user)
      user4 = create(:user)
      user5 = create(:user)
      Friendship.create({user_id: user1.id, friend_id: user2.id})
      Friendship.create({user_id: user1.id, friend_id: user3.id})
      Friendship.create({user_id: user1.id, friend_id: user4.id})
      Friendship.create({user_id: user1.id, friend_id: user5.id})

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user1)

      visit '/dashboard'

      within('#friends-list') do
        expect(page).to have_content(user2.first_name + " " + user2.last_name)
        expect(page).to have_content(user3.first_name + " " + user3.last_name)
        expect(page).to have_content(user4.first_name + " " + user4.last_name)
        expect(page).to have_content(user5.first_name + " " + user5.last_name)
      end
    end

    it 'I dont see an Add as Friend link of that user is already my friend' do
      user1 = create(:user, token:  ENV["GITHUB_API_TOKEN_R"])
      user2 = create(:user, token:  ENV["GITHUB_API_TOKEN"], username: 'takeller')
      Friendship.create({user_id: user1.id, friend_id: user2.id})

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user1)

      visit '/dashboard'

      within(".following-#{user2.username}") do
        expect(page).to_not have_content("Add as Friend")
      end
    end

    it "A user can add a friend" do
      VCR.use_cassette("github_dashboard_data_including_followers_and_following") do

        user = create(:user, token:  ENV["GITHUB_API_TOKEN_R"])
        user2 = create(:user, username: "takeller")

        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
        json_response = File.read('spec/fixtures/github_user_repos.json')
        stub_request(:get, "https://api.github.com/user/repos").
             with(
               headers: {
           	  'Accept'=>'*/*',
           	  'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
           	  'Authorization'=> "token #{ENV['GITHUB_API_TOKEN_R']}",
           	  'User-Agent'=>'Faraday v1.0.1'
               }).
             to_return(status: 200, body: json_response, headers: {})
        visit dashboard_path

        within ".friend-link-#{user2.username}" do
          click_link("Add as Friend")
        end
      end
    end 
  end
end
