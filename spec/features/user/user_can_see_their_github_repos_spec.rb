require 'rails_helper'

RSpec.describe 'User can see their Github repositories' do
  describe 'As a logged in user, in my dashboard' do
    describe 'under the Github section' do
      it 'I see a list of 5 repositories' do
        filename = 'teresa_github_repos.json'
        url = "https://api.github.com/user/repos"

        stub_get_json(url,filename)

        user = create(:user)
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

        visit '/dashboard'

        expect(page).to have_content("Github")

        expect(page).to have_css('.user_repo', count: 5)

        within(first('.user_repo')) do
          expect(page).to have_css('.name')
        end
      end
    end
  end
end
