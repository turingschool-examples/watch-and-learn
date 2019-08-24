require 'rails_helper'

describe 'As a logged in user' do
  describe 'When I visit /dashboard' do
    describe 'Then I should see a section for Github' do
      it 'should see a list of 5 repositories with the name of each Repo linking to the repo on Github' do
        user = create(:user)

        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
        allow_any_instance_of(ApplicationController).to receive(:current_token).and_return(ENV['GITHUB_TOKEN'])
        json_response = File.open("./fixtures/github_repos.json")
        stub_request(:get, "https://api.github.com/user/repos?sort=updated_at&access_token=#{ENV['GITHUB_TOKEN']}").
          to_return(status: 200, body: json_response)
        visit dashboard_path

        within ".github" do
          expect(page).to have_content("Github")
          expect(page).to have_link("brownfield-of-dreams")
          expect(page).to have_link("rales_engine")
          expect(page).to have_link("jungle_beats")
          expect(page).to have_link("here-be-dragons")
          expect(page).to have_link("monster_shop")
        end
      end

      it "does not display repos if there is no user token" do
        user = create(:user)

        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
        allow_any_instance_of(ApplicationController).to receive(:current_token).and_return(nil)

        visit dashboard_path

        expect(page).to_not have_css(".github")
      end
    end
  end
end
