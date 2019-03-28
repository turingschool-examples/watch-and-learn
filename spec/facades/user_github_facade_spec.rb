# frozen_string_literal: true

require 'rails_helper'

describe UserGithubFacade do
  it 'exists' do
    attributes = {}
    facade = described_class.new(attributes)

    expect(facade.is_a?(described_class)).to be(true)
  end

  context 'instance methods' do
    context '#user_repos' do
      it 'returns a list of the user\'s first 5 repos' do
        mock_user_dashboard_github

        user = create(:user, github_token: ENV['github_key'])

        facade = described_class.new(user)

        expect(facade.user_repos.is_a?(Array)).to be(true)
      end
    end

    context '#user_followers' do
      it 'returns a list of the user\'s followers' do
        mock_user_dashboard_github

        user = create(:user, github_token: ENV['github_key'])

        facade = described_class.new(user)

        expect(facade.user_followers.is_a?(Array)).to be(true)
      end
    end

    context '#user_following' do
      it 'returns a list of the people a user is following' do
        mock_user_dashboard_github

        user = create(:user, github_token: ENV['github_key'])

        facade = described_class.new(user)

        expect(facade.user_following.is_a?(Array)).to be(true)
      end
    end

    context '#user_friends' do
      it 'returns a list of the user\'s friends' do
        user = create(:user, github_token: ENV['github_key'])
        friend = create(:user)
        friend2 = create(:user)
        user.friends << friend
        user.friends << friend2
        facade = described_class.new(user)

        expect(facade.user_friends.count).to eq(2)
        expect(facade.user_friends[0].is_a?(User)).to be(true)
      end
    end

    context '#github_partial' do
      context 'for user with github_token' do
        it 'returns user dashboard partial path' do
          mock_user_dashboard_github

          user = create(:user, github_token: ENV['github_key'])

          facade = described_class.new(user)

          expect(facade.github_partial(user)).to eq('user_dashboard_github_info.html.erb')
        end
      end

      context 'for user without github_token' do
        it 'returns empty partial logout_path' do
          mock_user_dashboard_github

          user = create(:user)

          facade = described_class.new(user)

          expect(facade.github_partial(user)).to eq('user_dashboard_no_github_token.html.erb')
        end
      end
    end

    context '#user_bookmarks' do
      it 'returns all the videos a user has bookmarked, grouped by tutorial' do
        user = create(:user)
        videos = create_list(:video, 5)
        videos.each do |video|
          create(:user_video, user: user, video: video)
        end

        facade = described_class.new(user)

        expect(facade.user_bookmarks.length).to eq(5)
        expect(facade.user_bookmarks[0].is_a?(Video)).to be(true)
      end
    end
  end
end
