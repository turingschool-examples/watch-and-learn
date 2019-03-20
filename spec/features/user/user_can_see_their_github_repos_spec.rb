require 'rails_helper'

RSpec.describe 'User can see their Github repositories' do
  describe 'As a logged in user, in my dashboard' do
    describe "If I don't have a github token" do
      it "I don't see a github section" do
        filename = 'user_1_github_repos.json'
        url = "https://api.github.com/user/repos"

        stub_get_json(url,filename)

        user = create(:user)
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

        visit '/dashboard'

        expect(page).to_not have_content("Github")
      end
    end

    describe 'under the Github section' do
      it 'I see a list of 5 repositories' do
        filename = 'user_1_github_repos.json'
        url = "https://api.github.com/user/repos"

        stub_get_json(url,filename)

        user = create(:user)
        create(:github_token, user: user, token: ENV['USER_1_GITHUB_TOKEN'])
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

        visit '/dashboard'

        expect(page).to have_content("Github")

        expect(page).to have_css('.user_repo', count: 5)

        within(first('.user_repo')) do
          expect(page).to have_css('.name')
          expect(page).to have_link('battleship', href: "https://github.com/m-mrcr/battleship")
        end
      end

      it 'a second user sees their repositories' do
        filename = 'user_2_github_repos.json'
        url = "https://api.github.com/user/repos"

        stub_get_json(url,filename)

        user = create(:user)
        create(:github_token, user: user, token: ENV['USER_2_GITHUB_TOKEN'])

        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

        visit '/dashboard'

        expect(page).to have_content("Github")

        expect(page).to have_css('.user_repo', count: 5)

        within(first('.user_repo')) do
          expect(page).to have_css('.name')
          expect(page).to have_link('activerecord-obstacle-course', href: "https://github.com/nagerz/activerecord-obstacle-course")
        end
      end
    end
  end
end
