require 'rails_helper'

RSpec.describe 'As a logged in user' do
  scenario "can see a github section with 5 github repos", :vcr do 
    user = create(:user, github_token: ENV['GITHUB_ACCESS_TOKEN'] )

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit '/dashboard'

    within ".github" do 

      within "#github-#{repo_1.id}" do
        expect(page).to have_content(repo.name)
        expect(page).to have_link(repo.link)
      end
      within "#github-#{repo_2.id}" do

      end
      within "#github-#{repo_3.id}" do

      end
      within "#github-#{repo_4.id}" do

      end
      within "#github-#{repo_5.id}" do

      end
    end
      gs = GithubService.new 
      result = gs.get_json("/#{user}/repos", 0 ,user)

  end
end
