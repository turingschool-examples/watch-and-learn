require 'rails_helper'

describe 'A registered user' do
  before :each do
    @user = create(:user, token: ENV["GITHUB_TOKEN"])

  end
  it "can see a github section with 5 repos" do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

    visit(dashboard_path)

    expect(page).to have_css('.github')
  end

  it "can't see a github section if user has no token" do
    user_2 = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_2)

    visit(dashboard_path)

    expect(page).to_not have_css('.github')
  end

  it "can see a github section with only their repos" do
    user_2 = create(:user, token: ENV["GITHUB_TOKEN_2"])
    user_1_repos = GithubResults.new.repos(@user.token)
    user_2_repos = GithubResults.new.repos(user_2.token)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_2)

    visit(dashboard_path)

    within(first('.repo-link')) do
      expect(page).to have_content(user_2_repos.first.name)
      expect(page).to_not have_content(user_1_repos.first.name)
    end
  end

  it "can see all github followers " do
    user_2 = create(:user, token: ENV["GITHUB_TOKEN_2"])
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_2)
    visit(dashboard_path)

    within(".followers") do
      expect(page).to have_css(".follower", count: 4)
      expect(page).to_not have_content("jpc20")

    end
    # save_and_open_page
    # within(first(".follower")) do
    #   click_link
    #   expect(current_path).to not_eq(dashboard_path)
    # end
  end
  
  it "can see all github followings" do
    user_2 = create(:user, token: ENV["GITHUB_TOKEN_2"])
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_2)
    visit(dashboard_path)

    within(".followings") do
      expect(page).to have_css(".following", count: 4)
      expect(page).to have_content("jpc20")

    end

  end
end
