require 'rails_helper'

RSpec.describe UserDashboardFacade do
  before :each do
    @user = create(:user)
    create(:github_token, user: @user, token: ENV['USER_1_GITHUB_TOKEN'])
    @facade = UserDashboardFacade.new(@user)
  end
  it 'exists' do
    expect(@facade).to be_a(UserDashboardFacade)
  end

  context 'instance methods' do
    before :each do
      stub_user_1_dashboard
    end

    it 'returns an array of repositories' do
      expect(@facade.user_repos.class).to eq(Array)

      @facade.user_repos.each do |repo|
        expect(repo.class).to eq(Repository)
      end
    end

    it 'gets top repositories' do
      expect(@facade.top_user_repos(5).count).to eq(5)
    end

    it 'gets the github users the current user follows' do
      expect(@facade.users_followed.count).to eq(13)
    end

    it 'gets the users bookmarked videos' do
      tutorial1 = create(:tutorial)
      video1 = create(:video, tutorial_id: tutorial1.id)
      video2 = create(:video, tutorial_id: tutorial1.id)

      tutorial2 = create(:tutorial)
      video3 = create(:video, tutorial_id: tutorial2.id)

      tutorial3 = create(:tutorial)
      video4 = create(:video, tutorial_id: tutorial3.id)

      uv1 = create(:user_video, user: @user, video: video1)
      uv2 = create(:user_video, user: @user, video: video2)
      uv3 = create(:user_video, user: @user, video: video4)

      grouped_by_tutorial = {
        tutorial1 => [video1, video2],
        tutorial3 => [video4]
      }

      expect(@facade.user_bookmarked_videos).to eq(grouped_by_tutorial)
    end

    it 'get the users friends' do
      user2 = create(:user, uid: '12')
      user3 = create(:user, uid: '34')
      user4 = create(:user, uid: '56')

      friendship1 = create(:friendship, user: @user, friend: user2)
      friendship2 = create(:friendship, user: @user, friend: user3)

      expect(@facade.user_friends.count).to eq(2)
      expect(@facade.user_friends).to eq([user2, user3])
    end

  end
end
