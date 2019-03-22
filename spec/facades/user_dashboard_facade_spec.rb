require 'rails_helper'

RSpec.describe UserDashboardFacade do
  before :each do
    @user = create(:user)
    create(:github_token, user: @user, token: ENV['USER_1_GITHUB_TOKEN'])

  end
  it 'exists' do
    facade = UserDashboardFacade.new(@user)
    expect(facade).to be_a(UserDashboardFacade)
  end

  context 'instance methods' do
    it 'returns an array of repositories' do
      filename = 'user_1_github_repos.json'
      url = "https://api.github.com/user/repos?type=owner"

      stub_get_json(url,filename)

      facade = UserDashboardFacade.new(@user)
      expect(facade.user_repos.class).to eq(Array)

      facade.user_repos.each do |repo|
        expect(repo.class).to eq(Repository)
      end
    end

    it 'gets top repositories' do
      filename = 'user_1_github_repos.json'
      url = "https://api.github.com/user/repos?type=owner"

      stub_get_json(url,filename)

      facade = UserDashboardFacade.new(@user)

      expect(facade.top_user_repos(5).count).to eq(5)
    end

    it 'gets the github users the current user follows' do
      filename = 'user_1_github_following.json'
      url = "https://api.github.com/user/following"

      stub_get_json(url,filename)

      facade = UserDashboardFacade.new(@user)

      expect(facade.users_followed.count).to eq(12)
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

      facade = UserDashboardFacade.new(@user)
      grouped_by_tutorial = {
        tutorial1.title => [uv1, uv2],
        tutorial3.title => [uv3]
      }

      expect(facade.user_bookmarked_videos).to eq(grouped_by_tutorial)
    end

  end
end
