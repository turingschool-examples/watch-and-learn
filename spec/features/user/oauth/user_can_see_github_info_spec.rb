require 'rails_helper'

RSpec.describe 'When I visit my dashboard as a user' do
  before(:each) do
    @user = create(:user, token: ENV['MY_TOKEN'], connected?: true, handle: 'lrs8810')

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

    @repo_1 = Repo.new({name:'brownfield-of-dreams' , html_url: "https://github.com/lrs8810/brownfield-of-dreams"})
    @repo_2 = Repo.new({name:'brownfield-of-dreams1' , html_url: "https://github.com/lrs8810/brownfield-of-dreams"})
    @repo_3 = Repo.new({name:'brownfield-of-dreams2' , html_url: "https://github.com/lrs8810/brownfield-of-dreams"})

    @repos = [@repo_1, @repo_2, @repo_3]

    @follower_1 = Follower.new({login:'Sean' , html_url: "https://github.com/lrs8810/brownfield-of-dreams"})
    @follower_2 = Follower.new({login:'Sean2' , html_url: "https://github.com/lrs8810/brownfield-of-dreams"})
    @follower_3 = Follower.new({login:'Sean3' , html_url: "https://github.com/lrs8810/brownfield-of-dreams"})

    @followers = [@follower_1, @follower_2, @follower_3]

    @following_1 = Following.new({login:'Anna' , html_url: "https://github.com/lrs8810/brownfield-of-dreams"})
    @following_2 = Following.new({login:'Anna2' , html_url: "https://github.com/lrs8810/brownfield-of-dreams"})
    @following_3 = Following.new({login:'Anna3' , html_url: "https://github.com/lrs8810/brownfield-of-dreams"})

    @followings = [@following_1, @following_2, @following_3]
  end

  it 'I can see 5 repos that belong to me' do
    allow_any_instance_of(UserFacade).to receive(:repos).and_return(@repos)
    allow_any_instance_of(UserFacade).to receive(:followers).and_return(@followers)
    allow_any_instance_of(UserFacade).to receive(:followings).and_return(@followings)

    visit dashboard_path

    within ".user-repos" do
      expect(page).to have_content("Repos")
      expect(page).to have_link(@repo_1.name)
      expect(page).to have_link(@repo_2.name)
      expect(page).to have_link(@repo_3.name)
    end
  end

  it 'I can see all followers that belong to me' do
    allow_any_instance_of(UserFacade).to receive(:repos).and_return(@repos)
    allow_any_instance_of(UserFacade).to receive(:followers).and_return(@followers)
    allow_any_instance_of(UserFacade).to receive(:followings).and_return(@followings)

    visit dashboard_path

    within ".user-followers" do
      expect(page).to have_content("Followers")
      expect(page).to have_link(@follower_1.handle)
      expect(page).to have_link(@follower_2.handle)
      expect(page).to have_link(@follower_3.handle)
    end
  end

  it 'I can see all followings that belong to me' do
    allow_any_instance_of(UserFacade).to receive(:repos).and_return(@repos)
    allow_any_instance_of(UserFacade).to receive(:followers).and_return(@followers)
    allow_any_instance_of(UserFacade).to receive(:followings).and_return(@followings)

    visit dashboard_path

    within ".user-followings" do
      expect(page).to have_content("Following")
      expect(page).to have_link(@following_1.handle)
      expect(page).to have_link(@following_2.handle)
      expect(page).to have_link(@following_3.handle)
    end
  end

  it 'I can only see the user repos for a specific user' do
    user_2 = create(:user, token: 'friend', connected?: true, handle: 'bob')

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_2)

    repo_1 = Repo.new({name:'dreams' , html_url: "https://github.com/lrs8810/dreams"})
    repo_2 = Repo.new({name:'dreams1' , html_url: "https://github.com/lrs8810/dreams"})
    repo_3 = Repo.new({name:'dreams2' , html_url: "https://github.com/lrs8810/dreams"})

    repos = [repo_1, repo_2, repo_3]

    follower_1 = Follower.new({login:'Bob' , html_url: "https://github.com/lrs8810/brownfield-of-dreams"})
    follower_2 = Follower.new({login:'Bob2' , html_url: "https://github.com/lrs8810/brownfield-of-dreams"})
    follower_3 = Follower.new({login:'Bob3' , html_url: "https://github.com/lrs8810/brownfield-of-dreams"})

    followers = [follower_1, follower_2, follower_3]

    following_1 = Following.new({login:'Anna' , html_url: "https://github.com/lrs8810/brownfield-of-dreams"})
    following_2 = Following.new({login:'Anna2' , html_url: "https://github.com/lrs8810/brownfield-of-dreams"})
    following_3 = Following.new({login:'Anna3' , html_url: "https://github.com/lrs8810/brownfield-of-dreams"})

    followings = [following_1, following_2, following_3]


    allow_any_instance_of(UserFacade).to receive(:repos).and_return(repos)
    allow_any_instance_of(UserFacade).to receive(:followers).and_return(followers)
    allow_any_instance_of(UserFacade).to receive(:followings).and_return(followings)

    visit dashboard_path

    within ".user-repos" do
      expect(page).to_not have_link(@repo_1.name)
      expect(page).to_not have_link(@repo_2.name)
      expect(page).to_not have_link(@repo_3.name)
    end
  end

  it 'if user is not connected do not show Github section' do
    user_2 = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_2)

    expect(page).to_not have_css('.github-info')
  end
end
