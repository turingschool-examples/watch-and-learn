require 'rails_helper'

describe 'Dashboard facade' do
  it 'exists' do
    facade = DashboardFacade.new(nil)

    expect(facade).to be_a(DashboardFacade)
  end

  describe 'instance methods' do
    describe '.repositories' do
      it 'returns a collection of repositories for the user' do
        user = create(:user)
        allow_any_instance_of(User).to receive(:github_token).and_return(ENV['GITHUB_API_KEY'])
        VCR.use_cassette("/facades/dashboard_repositories_request") do
          facade = DashboardFacade.new(user)

          expect(facade.repositories).to be_a(Array)
          expect(facade.repositories.first).to be_a(Repository)
        end
      end
    end

    describe '.followers' do
      it 'returns all followers for the user' do
        user = create(:user)
        allow_any_instance_of(User).to receive(:github_token).and_return(ENV['GITHUB_API_KEY'])
        VCR.use_cassette("/facades/dashboard_follower_request") do
          facade = DashboardFacade.new(user)

          expect(facade.followers).to be_a(Array)
          expect(facade.followers.first).to be_a(GithubUser)
        end
      end
    end

    describe '.following' do
      it 'returns all followed users on github' do
        user = create(:user)
        allow_any_instance_of(User).to receive(:github_token).and_return(ENV['GITHUB_API_KEY'])
        VCR.use_cassette("/facades/dashboard_following_request") do
          facade = DashboardFacade.new(user)

          expect(facade.following).to be_a(Array)
          expect(facade.following.first).to be_a(GithubUser)
        end
      end
    end
    describe '.bookmarked_videos' do
      it 'returns the videos the current user has bookmarked' do
        tutorial = create(:tutorial)
        video = create(:video, position: 1, tutorial_id: tutorial.id)
        user = create(:user)
        create(:user_video, user_id: user.id, video_id: video.id)

        facade = DashboardFacade.new(user)
        expected = [video]

        expect(facade.bookmarked_videos).to eq(expected)
      end
    end

    describe 'bookmark_segment' do
      it 'returns empty_bookmarks when user has no bookmarks' do
        user = create(:user)
        allow_any_instance_of(DashboardFacade).to receive(:bookmarked_videos).and_return([])
        facade = DashboardFacade.new(user)

        expect(facade.bookmark_segment).to eq('empty_bookmarks')
      end
      it 'returns bookmarks when a user has made bookmarks' do
        user = create(:user)
        allow_any_instance_of(DashboardFacade).to receive(:bookmarked_videos).and_return(["video"])
        facade = DashboardFacade.new(user)

        expect(facade.bookmark_segment).to eq('bookmarks')
      end
    end

    describe 'render_github' do
      it 'returns github_connect if user is not connected to github' do
        user = create(:user)
        allow_any_instance_of(User).to receive(:github_token).and_return(nil)
        facade = DashboardFacade.new(user)

        expect(facade.render_github).to eq('github_connect')
      end

      it 'returns github if user is connected to github' do
        user = create(:user)
        allow_any_instance_of(User).to receive(:github_token).and_return("iamafaketokenhehe")
        facade = DashboardFacade.new(user)

        expect(facade.render_github).to eq('github')
      end
    end

    describe '.friends' do
      it 'returns the friends of the current user' do
        user = create(:github_user)
        potential_friend = create(:github_user, uid: 41562392)
        current_friend = create(:github_user)
        requested_friend = create(:github_user)
        current_friend_1 = Friend.create(user: user, friend_user: current_friend)
        current_friend_2 = Friend.create(user: current_friend, friend_user: user)
        requested_friend_1 = Friend.create(user: user, friend_user: requested_friend)
        facade = DashboardFacade.new(user)

        expect(facade.friends).to eq([current_friend])
      end
    end

    describe '.pending_requests' do
      it 'returns the requests the current user has pending' do
        user = create(:github_user)
        potential_friend = create(:github_user, uid: 41562392)
        current_friend = create(:github_user)
        requested_friend = create(:github_user)
        current_friend_1 = Friend.create(user: user, friend_user: current_friend)
        current_friend_2 = Friend.create(user: current_friend, friend_user: user)
        requested_friend_1 = Friend.create(user: requested_friend, friend_user: user)
        facade = DashboardFacade.new(user)

        expect(facade.pending_requests).to eq([requested_friend])
      end
    end
  end
end
