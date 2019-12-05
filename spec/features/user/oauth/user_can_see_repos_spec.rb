require 'rails_helper'

RSpec.describe 'When I visit my dashboard as a user' do
  it 'I can see 5 repos that belong to me' do
    user = create(:user, token: '855b3d045bcf9a7664f9af4897b6110cc61e77b7', connected?: true)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    repo_1 = Repo.new({name:'brownfield-of-dreams' , html_url: "https://github.com/lrs8810/brownfield-of-dreams"})
    repo_2 = Repo.new({name:'brownfield-of-dreams1' , html_url: "https://github.com/lrs8810/brownfield-of-dreams"})
    repo_3 = Repo.new({name:'brownfield-of-dreams2' , html_url: "https://github.com/lrs8810/brownfield-of-dreams"})

    repos = [repo_1, repo_2, repo_3]

    follower_1 = Follower.new({login:'Sean' , html_url: "https://github.com/lrs8810/brownfield-of-dreams"})
    follower_2 = Follower.new({login:'Sean2' , html_url: "https://github.com/lrs8810/brownfield-of-dreams"})
    follower_3 = Follower.new({login:'Sean3' , html_url: "https://github.com/lrs8810/brownfield-of-dreams"})

    followers = [follower_1, follower_2, follower_3]

    following_1 = Following.new({login:'Anna' , html_url: "https://github.com/lrs8810/brownfield-of-dreams"})
    following_2 = Following.new({login:'Anna2' , html_url: "https://github.com/lrs8810/brownfield-of-dreams"})
    following_3 = Following.new({login:'Anna3' , html_url: "https://github.com/lrs8810/brownfield-of-dreams"})

    followings = [following_1, following_2, following_3]

    allow_any_instance_of(UserFacade).to receive(:repos).and_return(repos)
    allow_any_instance_of(UserFacade).to receive(:followers).and_return(followers)
    allow_any_instance_of(UserFacade).to receive(:followings).and_return(followings)

    visit '/dashboard'

    within ".user-repos" do
      expect(page).to have_content("Repos")
      expect(page).to have_link(repo_1.name)
      expect(page).to have_link(repo_2.name)
      expect(page).to have_link(repo_3.name)
    end
  end
end
