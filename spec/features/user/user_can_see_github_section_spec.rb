require 'rails_helper'

describe "When visting the dashboard as a logged in User " do
  it "can see a section for 'Github' with 5 repo's", :vcr do
    user = create(:user, github_token: ENV['GITHUB_ACCESS_TOKEN'])

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit '/dashboard'

    within ".github" do
      within "#github-#{repo_1.id}" do
        expect(page).to have_content(repo.name)
        expect(page).to have_link(repo.link)
      end
      within "#github-#{repo_2.id}" do
        ​expect(page).to have_content(repo.name)
        expect(page).to have_link(repo.link)
      end
      within "#github-#{repo_3.id}" do
​       expect(page).to have_content(repo.name)
       expect(page).to have_link(repo.link)
      end
      within "#github-#{repo_4.id}" do
​       expect(page).to have_content(repo.name)
       expect(page).to have_link(repo.link)
      end
      within "#github-#{repo_5.id}" do
​       expect(page).to have_content(repo.name)
       expect(page).to have_link(repo.link)
      end
    end
  end
end
