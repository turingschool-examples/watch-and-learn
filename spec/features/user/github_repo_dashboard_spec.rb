require 'rails_helper'


describe 'show five github repos on user dashboard page' do
  it 'show repos' do
    user = create(:user, token: '6e4c758b3a5e0a73efa789b71f6b54714b5663de')
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    VCR.use_cassette('github_repos_for_user') do
      visit '/dashboard'

      expect(page).to have_content("Github Repos")
      within "#repos" do
        expect(page).to have_css('#dot', count: 5)
      end
    end
  end
end
